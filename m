Content-Type: multipart/mixed; boundary="===============2248630114210688530=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: allow MPTCP sockets by default
Date: Wed, 02 Oct 2019 23:02:27 +0200
Message-ID: <25fd6f87-7f68-da8e-429d-07122d186cb1@tessares.net>
In-Reply-To: alpine.OSX.2.21.1909251123400.26111@leoliu1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2002

--===============2248630114210688530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 25/09/2019 20:28, Mat Martineau wrote:
> =

> On Wed, 25 Sep 2019, Matthieu Baerts wrote:
> =

>> At LPC2019, the feedback was that it should be easy to create MPTCP
>> sockets to have testers. But still important to have ways to disable the
>> creation of new MPTCP sockets. It can be easily done via this new
>> sysctl, CGroups or SELinux. Netfilter can also be used to close existing
>> MPTCP connections if needed.

Thank you for the review!

- bdccc294628e: "squashed" in "mptcp: new sysctl to control the
activation per NS"
- 4a6a27ba8515: "squashed" in "mptcp: add basic kselftest for mptcp"
- d612190690a9..008467ef92e5: result

Cheers,
Matt

>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0 To be squashed in "mptcp: new sysctl to control the activat=
ion per NS"
>>
>> =C2=A0=C2=A0 v2:
>> =C2=A0=C2=A0=C2=A0 - fix typo spotted by Mat ("static int" instead of "s=
tatic void")
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
> =

> One more thing, I would simply say that we are providing a way to
> control access to the feature for those that need to turn it on or off
> for any reason. The point about code review and security is true of any
> new code :)
> =

> You are welcome to merge with or without this suggested change.
> =

> Mat
> =

> =

> =

>>
>> The value of this new sysctl can be different per namespace. We can then
>> restrict the usage of MPTCP to the selected NS. In case of serious
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index 8d9f15f02369..33de3ced2ba7 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -43,6 +43,11 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0{}
>> };
>>
>> +static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>> +{
>> +=C2=A0=C2=A0=C2=A0 pernet->mptcp_enabled =3D 1;
>> +}
>> +
>> static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet
>> *pernet)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0struct ctl_table_header *hdr;
>> @@ -85,6 +90,8 @@ static int __net_init mptcp_net_init(struct net *net)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_pernet *pernet =3D mptcp_get_pernet=
(net);
>>
>> +=C2=A0=C2=A0=C2=A0 mptcp_pernet_set_defaults(pernet);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0return mptcp_pernet_new_table(net, pernet);
>> }
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index d029bdc5946d..7d312bd9ac77 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -45,7 +45,6 @@ trap cleanup EXIT
>> for i in 1 2 3 4;do
>> =C2=A0=C2=A0=C2=A0=C2=A0ip netns add ns$i || exit $ksft_skip
>> =C2=A0=C2=A0=C2=A0=C2=A0ip -net ns$i link set lo up
>> -=C2=A0=C2=A0=C2=A0 ip netns exec ns$i sysctl -q net.mptcp.enabled=3D1
>> done
>>
>> #=C2=A0 ns1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ns2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ns3=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ns4
>> @@ -111,7 +110,14 @@ check_mptcp_disabled()
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0disabled_ns=3D"ns_disabled"
>> =C2=A0=C2=A0=C2=A0=C2=A0ip netns add ${disabled_ns} || exit $ksft_skip
>> -=C2=A0=C2=A0=C2=A0 # by default: sysctl net.mptcp.enabled=3D0
>> +
>> +=C2=A0=C2=A0=C2=A0 # net.mptcp.enabled should be enabled by default
>> +=C2=A0=C2=A0=C2=A0 if [ "$(ip netns exec ${disabled_ns} sysctl net.mptc=
p.enabled |
>> awk '{ print $3 }')" -ne 1 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo -e "net.mptcp.enabled s=
ysctl is not 1 by default\t[ FAIL ]"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 ip netns exec ${disabled_ns} sysctl -q net.mptcp.ena=
bled=3D0
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0local err=3D0
>> =C2=A0=C2=A0=C2=A0=C2=A0LANG=3DC ip netns exec ${disabled_ns} ./mptcp_co=
nnect -t $timeout -p
>> 10000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
>> @@ -119,12 +125,12 @@ check_mptcp_disabled()
>> =C2=A0=C2=A0=C2=A0=C2=A0ip netns delete ${disabled_ns}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if [ ${err} -eq 0 ]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo -e "MPTCP is not disabl=
ed by default as expected\t[ FAIL ]"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo -e "New MPTCP socket ca=
nnot be blocked via sysctl\t[
>> FAIL ]"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> =C2=A0=C2=A0=C2=A0=C2=A0fi
>>
>> -=C2=A0=C2=A0=C2=A0 echo -e "MPTCP is disabled by default as expected\t[=
 OK ]"
>> +=C2=A0=C2=A0=C2=A0 echo -e "New MPTCP socket can be blocked via sysctl\=
t[ OK ]"
>> =C2=A0=C2=A0=C2=A0=C2=A0return 0
>> }
>>
>> --=C2=A0
>> 2.20.1
>>
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>>
> =

> -- =

> Mat Martineau
> Intel

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2248630114210688530==--
