Content-Type: multipart/mixed; boundary="===============4621411388341310326=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] MAINTAINERS: Add MPTCP maintainer
Date: Fri, 06 Dec 2019 22:47:30 +0100
Message-ID: <64ea55ae-a82a-f028-1247-97f7d8ad7c92@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912061324270.72972@pminglan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2837

--===============4621411388341310326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Thank you for your reply!

On 06/12/2019 22:38, Mat Martineau wrote:
> =

> On Fri, 6 Dec 2019, Matthieu Baerts wrote:
> =

>> Hi Mat,
>>
>> On 06/12/2019 00:05, Mat Martineau wrote:
>>> When we discussed maintainership in an earlier meeting
>>> (https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/HCII2=
622GWZCOMQCBOMQBJKZI247YIH5/) =

>>>
>>> there was a loose consensus that it would be best to have multiple
>>> maintainers. I nominate Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>> as a co-maintainer, what do you think?
>>>
>>> squashto: mptcp: Add MPTCP to skb extensions
>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>> ---
>>> =C2=A0 MAINTAINERS | 6 ++++++
>>> =C2=A0 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8608724835dd..0576b17abd44 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -11538,6 +11538,12 @@ F:=C2=A0=C2=A0=C2=A0 net/ipv6/calipso.c
>>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 net/netfilter/xt_CONNSECMARK.c
>>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 net/netfilter/xt_SECMARK.c
>>> =C2=A0 +NETWORKING [MPTCP]
>>> +M:=C2=A0=C2=A0=C2=A0 Mat Martineau <mathew.j.martineau(a)linux.intel.c=
om>
>>> +L:=C2=A0=C2=A0=C2=A0 netdev(a)vger.kernel.org
>>
>> I see that some have two mailing-lists with a note.
>>
>> =C2=A0L:=C2=A0=C2=A0=C2=A0 mptcp(a)lists.01.org (moderated for non-subsc=
ribers)
> =

> I noticed this too. One major issue is that the lists.01.org admins =

> asked me to work around their moderation bug by rejecting non-subscribed =

> senders.
> =

> (There's a bug in the specific version of mailman that prevents list =

> owners from approving or rejecting held messages, possibly due to =

> corrupt message format in spam. Every time messages are held I have to =

> get a sysadmin to log in and fix it)
> =

> Given that, I think it's better to monitor netdev for updates. Another =

> alternative is to open up the list for non-member senders but given =

> current patterns that would forward 1-2 spam messages per week. I'm =

> flexible here, I have so far leaned toward keeping spam out.

If they go directly to my spam folder like the ones from netdev, that's =

fine for me.
Or can we reject emails from non-subscribers?

>>
>> Can we not do the same?
>>
>> Should we not also add these ones?
>>
>> =C2=A0Q:=C2=A0=C2=A0=C2=A0 https://patchwork.ozlabs.org/project/mptcp/li=
st/
>> =C2=A0W:=C2=A0=C2=A0=C2=A0 https://github.com/multipath-tcp/mptcp_net-ne=
xt/wiki
>> =C2=A0T:=C2=A0=C2=A0=C2=A0 git git://github.com/multipath-tcp/mptcp_net-=
next.git
>> =C2=A0B:=C2=A0=C2=A0=C2=A0 https://github.com/multipath-tcp/mptcp_net-ne=
xt/issues
>>
>> (not sure about the last one)
> =

> We haven't discussed what maintenance of MPTCP will look like after code =

> is merged, so for now my assumption is that maintenance fixes would look =

> more like TCP and TLS as far as git trees and patch management are =

> concerned. I'm

That's true. But for the moment, there are still new features to =

develop. So I guess it makes sense to keep Patchwork and the git repo =

for a while. We can remove it later if it no longer makes sense.

> The bug tracker would be a helpful pointer so people aren't trying to =

> look up MPTCP bugs in the netdev archives.

I think that too.

>>
>> Also it is not linked to this but do you think at some points we =

>> should add some Documentations?
> =

> Definitely!

But not urgent :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4621411388341310326==--
