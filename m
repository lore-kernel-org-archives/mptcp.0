Content-Type: multipart/mixed; boundary="===============7669497008338967075=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH net] mptcp: select CRYPTO
Date: Wed, 12 Feb 2020 20:52:22 +0100
Message-ID: <3429bd63-cb52-3898-eb04-e25b5e87327c@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2002121126560.31766@echiprou-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3635

--===============7669497008338967075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 12/02/2020 20:31, Mat Martineau wrote:
> On Wed, 12 Feb 2020, Matthieu Baerts wrote:
> =

>> Without this modification and if CRYPTO is not selected, we have this
>> warning:
>>
>> =C2=A0WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
>> =C2=A0=C2=A0 Depends on [n]: CRYPTO [=3Dn]
>> =C2=A0=C2=A0 Selected by [y]:
>> =C2=A0=C2=A0 - MPTCP [=3Dy] && NET [=3Dy] && INET [=3Dy]
>>
>> MPTCP selects CRYPTO_LIB_SHA256 which depends on CRYPTO. CRYPTO is now
>> selected to avoid this issue.
>>
>> Fixes: 65492c5a6ab5 (mptcp: move from sha1 (v0) to sha256 (v1))
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>> net/mptcp/Kconfig | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
>> index 49f6054e7f4e..a9ed3bf1d93f 100644
>> --- a/net/mptcp/Kconfig
>> +++ b/net/mptcp/Kconfig
>> @@ -4,6 +4,7 @@ config MPTCP
>> =C2=A0=C2=A0=C2=A0=C2=A0depends on INET
>> =C2=A0=C2=A0=C2=A0=C2=A0select SKB_EXTENSIONS
>> =C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_SHA256
>> +=C2=A0=C2=A0=C2=A0 select CRYPTO
>> =C2=A0=C2=A0=C2=A0=C2=A0help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Multipath TCP (MPTCP) connections send an=
d receive data over =

>> multiple
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subflows in order to utilize multiple net=
work paths. Each subflow
>> -- =

>> 2.25.0
> =

> Even though the config system prints that warning, it looks like sha256 =

> is compiled and linked even without CONFIG_CRYPTO. Since we end up =

> needing CONFIG_CRYPTO anyway for crypto_memneq, it's not bad to include =

> it now, but it doesn't seem to be strictly necessary.

Thank you for the review.

I agree with you. I don't even know where the dependence is added. In =

the code, we can see:

   config CRYPTO_LIB_SHA256
        tristate

But "make menuconfig" shows the dependence with CRYPTO.

Do you think we don't need to send it to "net"?
Maybe I should add something like this in the commit message?

   Even though the config system prints that warning, it looks like =

sha256 is compiled and linked even without CONFIG_CRYPTO. Since we will =

end up needing CONFIG_CRYPTO anyway in future commits that will be sent =

for the next version, we propose to add it now to fix the warning and =

prepare for the next commits.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7669497008338967075==--
