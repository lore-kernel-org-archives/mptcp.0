Content-Type: multipart/mixed; boundary="===============1400223420415525650=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Socket layer changes to MPTCP
Date: Wed, 28 Mar 2018 16:16:30 -0700
Message-ID: <077d13b4-f0a3-9079-d59e-bec24c919970@oracle.com>
In-Reply-To: alpine.OSX.2.21.1803281344420.16850@fmorale1-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 443

--===============1400223420415525650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/28/2018 02:39 PM, Mat Martineau wrote:
>
> Hi Rao -
>
> On Wed, 28 Mar 2018, Rao Shoaib wrote:
>
>> I have recently noticed that the group is working on socket level =

>> changes to MPTCP.
>>
>> Can a summary of the issues and how the changes will solve them be =

>> posted to the list?=C2=A0 That would help any new participants as well. =
If =

>> they have already been discussed please point me to the thread.
>
> I proposed moving away from the metasocket architecture last summer:
> https://lists.01.org/pipermail/mptcp/2017-July/000064.html
>
> When I reviewed the multipath-tcp.org implementation of MPTCP, my =

> assessment was (and is) that using metasockets resulted in more =

> intrusive code changes for TCP. The more partitioned approach of KCM =

> and RDS (using internal kernel sockets) shows an example of in-kernel =

> features that the maintainers have merged. The approach seemed =

> feasible and I proposed it as a direction to go.
Thanks for pointing the thread out. That was a proposal we never agreed =

on it=C2=A0 ?
Here is my response to it.

"""""
I agree with the above approach but want to expand on the initial goal.

Our initial goal must be to put a minimal (bare bones) MPTCP =

implementation in main stream Linux. That could mean no fancy scheduling =

schemes, just simple round robin or just active/standby. Implementing =

minimal MPTCP functionality will pretty much expose how main TCP code =

will be impacted. Any future work to add features will be confined to =

changes within MPTCP and should not be a concern right now. Such an =

implementation will also be fully RFC compliant.

I agree with you that upstream folks would want an opt-in option. I am =

in favor of a completely different socket family as that would leave tcp =

socket code untouched. However we should talk to upstream folks once again.

I should have been more specific, I was referring to the socket layer =

changes. Now that I have implemented MPTCP on Linux and understand the =

design better I don't think using a separate

I would like us to use as much code as possible from the current =

implementation. In fact if for some reason (I don't see one) we can not =

ship a minimal implementation than I prefer that we just port the =

current implementation and worry about architectural issues later.

In short, I would like our focus to be on putting a minimal MPTCP =

implementation in Linux so that we have a stake in the ground. =

Performance and Features can come later. That does not mean that the =

quality of our implementation is so bad that it is unusable.

Shoaib

""""""""""""""

I was OK using KCM or a different socket family, but nothing else, as I =

say using a socket family would only save changes to the socket code.

Since our initial goal was not adhered to and I have had more =

experience, I would like a technical analysis or better yet an =

implementation that supports the said claims. Any mention of upstream =

should have pointers to the email threads or should not be used. KCM and =

RDS are completely different, they do not add options to TCP header or =

deal with TCP state machine.

I have submitted a patch that provides a complete working implementation =

based on the current design. It can be used as a reference to point out =

how the proposed solution would be better.

>
>> It will also help if it can be made clear how these changes will =

>> expedite implementation of a basic MPTCP implementation. I believe =

>> that is the current goal, but my understanding may be incorrect.
>
> I think it will expedite upstreaming in the sense that metasockets =

> would never get merged upstream, and that a more partitioned approach =

> with dedicated subflow sockets has a reasonable shot. That's my =

> opinion based on what I've seen from the maintainers (in terms of =

> mailing list discussions, conversations, and what they have merged in =

> the past).
>
> Now, Christoph has raised the topic for more detailed discussion with =

> regard to the specifics of the multipath-tcp.org implementation. I =

> don't think anything is a foregone conclusion in terms of this aspect =

> of the upstreaming project, you can propose a different approach to =

> discuss.
I want to point out that folks propose a lot of enhancements on Netdev =

and IETF with valid uses cases. 99.99% get rejected. There has to be =

very valid reasons -- We are not going to build a kitchen sink of =

options that will make the design complex and unmaintainable. If a =

vendor has certain requirements they need to provide us a list that we =

evaluate and find out the best way to implement it if we choose to. We =

are not there yet and talking about any kind of options is premature.

Thanks,

Shoaib
> Thanks,
>
> -- =

> Mat Martineau
> Intel OTC


--===============1400223420415525650==--
