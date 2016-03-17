require 'semver'

# Legacy versions of MegaCLI require different arguments to determine certain
# software and firmware versions.
Facter.add(:megacli_legacy) do
  megacli = Facter.value(:megacli)
  megacli_version = Facter.value(:megacli_version)

  setcode do
    next if megacli.nil?
    next if megacli_version.nil?

    # Modern version assumed from changelog at
    # http://www.lsi.com/downloads/Public/RAID%20Controllers/RAID%20Controllers%20Common%20Files/Linux%20MegaCLI%208.07.10.txt
    actual_version = SemVer.new(megacli_version)
    modern_version = SemVer.new('8.02.16')

    actual_version < modern_version

  end
end
