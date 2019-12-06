Content-Type: multipart/mixed; boundary="===============4832932557301512692=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] MAINTAINERS: Add MPTCP maintainer
Date: Fri, 06 Dec 2019 13:38:49 -0800
Message-ID: <alpine.OSX.2.21.1912061324270.72972@pminglan-mobl.amr.corp.intel.com>
In-Reply-To: 6d3e069f-8f96-db7f-e7c6-c1ebc66fda78@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2835

--===============4832932557301512692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 6 Dec 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 06/12/2019 00:05, Mat Martineau wrote:
>> When we discussed maintainership in an earlier meeting
>> (https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/HCII26=
22GWZCOMQCBOMQBJKZI247YIH5/)
>> there was a loose consensus that it would be best to have multiple
>> maintainers. I nominate Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> as a co-maintainer, what do you think?
>> =

>> squashto: mptcp: Add MPTCP to skb extensions
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>> =

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8608724835dd..0576b17abd44 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11538,6 +11538,12 @@ F:	net/ipv6/calipso.c
>>   F:	net/netfilter/xt_CONNSECMARK.c
>>   F:	net/netfilter/xt_SECMARK.c
>>   +NETWORKING [MPTCP]
>> +M:	Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> +L:	netdev(a)vger.kernel.org
>
> I see that some have two mailing-lists with a note.
>
>  L:	mptcp(a)lists.01.org (moderated for non-subscribers)

I noticed this too. One major issue is that the lists.01.org admins asked =

me to work around their moderation bug by rejecting non-subscribed =

senders.

(There's a bug in the specific version of mailman that prevents list =

owners from approving or rejecting held messages, possibly due to corrupt =

message format in spam. Every time messages are held I have to get a =

sysadmin to log in and fix it)

Given that, I think it's better to monitor netdev for updates. Another =

alternative is to open up the list for non-member senders but given =

current patterns that would forward 1-2 spam messages per week. I'm =

flexible here, I have so far leaned toward keeping spam out.

>
> Can we not do the same?
>
> Should we not also add these ones?
>
>  Q:	https://patchwork.ozlabs.org/project/mptcp/list/
>  W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
>  T:	git git://github.com/multipath-tcp/mptcp_net-next.git
>  B:	https://github.com/multipath-tcp/mptcp_net-next/issues
>
> (not sure about the last one)

We haven't discussed what maintenance of MPTCP will look like after code =

is merged, so for now my assumption is that maintenance fixes would look =

more like TCP and TLS as far as git trees and patch management are =

concerned. I'm

The bug tracker would be a helpful pointer so people aren't trying to look =

up MPTCP bugs in the netdev archives.

>
> Also it is not linked to this but do you think at some points we should a=
dd =

> some Documentations?

Definitely!

--
Mat Martineau
Intel
--===============4832932557301512692==--
