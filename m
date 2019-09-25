Content-Type: multipart/mixed; boundary="===============4229347159646133673=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: allow MPTCP sockets by default
Date: Wed, 25 Sep 2019 15:05:28 +0200
Message-ID: <887ad151-5c03-16c9-740c-5bc72c326979@tessares.net>
In-Reply-To: alpine.OSX.2.21.1909241501120.16564@leoliu1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1924

--===============4229347159646133673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 25/09/2019 00:45, Mat Martineau wrote:
> =

> On Tue, 24 Sep 2019, Matthieu Baerts wrote:
> =

>> At LPC2019, the feedback was that it should be easy to create MPTCP
>> sockets to have testers. But still important to have ways to disable the
>> creation of new MPTCP sockets. It can be easily done via this new
>> sysctl, CGroups or SELinux. Netfilter can also be used to close existing
>> MPTCP connections if needed.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
> =

> Thanks Matthieu - I'd also noticed that we needed this. One comment
> below, otherwise looks good.

Thank you for the review!

>>
>> Notes:
>> =C2=A0=C2=A0 To be squashed in "mptcp: new sysctl to control the activat=
ion per NS"
>>
>> .topmsg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++----
>> net/mptcp/ctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 7 +++++++
>> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++++----
>> 3 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/.topmsg b/.topmsg
>> index 7ff9f3c96ff3..373f94c4b4bd 100644
>> --- a/.topmsg
>> +++ b/.topmsg
>> @@ -5,10 +5,9 @@ New MPTCP sockets will return -ENOPROTOOPT if MPTCP
>> support is disabled
>> for the current net namespace.
>>
>> For security reasons, it is interesting to have a global switch for
>> -MPTCP. To start, MPTCP will be disabled by default and only privileged
>> -users will be able to modify this. The reason is that because MPTCP is
>> -new, it will not be tested and reviewed by many and security issues can
>> -then take time to be discovered and fixed.
>> +MPTCP. The reason is that because MPTCP is new, it will not be tested
>> +and reviewed by many and security issues can then take time to be
>> +discovered and fixed.
>>
>> The value of this new sysctl can be different per namespace. We can then
>> restrict the usage of MPTCP to the selected NS. In case of serious
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index 8d9f15f02369..07152c249531 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -43,6 +43,11 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0{}
>> };
>>
>> +static int mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> =

> Should be 'static void'? This code gives a compile warning because
> there's no return statement.

Oh good catch, I don't know how I missed that!

I just sent a v2!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4229347159646133673==--
