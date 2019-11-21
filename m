Content-Type: multipart/mixed; boundary="===============8756756484811168579=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] selftests: fixup for IPv6 tests
Date: Thu, 21 Nov 2019 15:19:41 +0100
Message-ID: <e6bf37d9310ab48245e0301b2d6b66fec165c4c4.camel@redhat.com>
In-Reply-To: ea96e132-5ec6-a2c3-06b6-5710e3c7b18c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2649

--===============8756756484811168579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 15:14 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 21/11/2019 13:25, Paolo Abeni wrote:
> > Some distros still have the 'ping6' command, take care of that.
> > Addiotnally, setting 'noadad' on ipv6 addresses will avoid
> > explicit waits later
> > =

> > Squash-to: "mptcp: add basic kselftest for mptcp"
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> >   .../selftests/net/mptcp/mptcp_connect.sh      | 27 +++++++++----------
> >   1 file changed, 12 insertions(+), 15 deletions(-)
> > =

> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools=
/testing/selftests/net/mptcp/mptcp_connect.sh
> > index a03760d12eff..9a065183545c 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -17,6 +17,7 @@ ethtool_random_on=3Dtrue
> >   tc_delay=3D"$((RANDOM%400))"
> >   tc_loss=3D$((RANDOM%101))
> >   tc_reorder=3D""
> > +which ping6 > /dev/null 2>&1 && ping6=3D$(which ping6) || ping6=3D$(wh=
ich ping)
> =

> Just out of curiosity: why is it not OK to use 'ping -6' on these distro?
> =

> Note that you can also use:
> =

>    ping6=3D$(which ping6 || which ping)

I shamefully copied the existing code from other self-tests script to
deal with that. I think adding '-6' for ipv6 address should work
everywhere, let me try that.
> =

> (I don't think 'which' is supposed to print something if the program is =

> not available)
> =

> >   if [ $tc_loss -eq 100 ];then
> >   	tc_loss=3D1%
> > @@ -124,18 +125,18 @@ ip link add ns2eth3 netns "$ns2" type veth peer n=
ame ns3eth2 netns "$ns3"
> >   ip link add ns3eth4 netns "$ns3" type veth peer name ns4eth3 netns "$=
ns4"
> >   =

> >   ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
> > -ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2
> > +ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
> =

> What a sad option :'(
> =

> But good idea (Luke)!
> =

> [...]
> =

> > @@ -493,12 +496,6 @@ show_all_ipv6()
> >   	done
> >   }
> >   =

> > -# Allow DAD to finish
> > -for dad in $(seq 20); do
> > -	show_all_ipv6 | grep -q -e tentative -e temporary || break
> =

> A detail but I guess we can also remove the show_all_ipv6() function =

> declared just above that.

Yep, will drop in next iteration.

Thanks,

Paolo

--===============8756756484811168579==--
