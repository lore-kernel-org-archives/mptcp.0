Content-Type: multipart/mixed; boundary="===============1151898148862584156=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Socket layer changes to MPTCP
Date: Mon, 02 Apr 2018 12:21:16 -0700
Message-ID: <alpine.OSX.2.21.1803291455320.39118@mjmartin-mac01.sea.intel.com>
In-Reply-To: 077d13b4-f0a3-9079-d59e-bec24c919970@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 498

--===============1151898148862584156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao,

On Wed, 28 Mar 2018, Rao Shoaib wrote:

>
>
> On 03/28/2018 02:39 PM, Mat Martineau wrote:
>> =

>> Hi Rao -
>> =

>> On Wed, 28 Mar 2018, Rao Shoaib wrote:
>> =

>>> I have recently noticed that the group is working on socket level chang=
es =

>>> to MPTCP.
>>> =

>>> Can a summary of the issues and how the changes will solve them be post=
ed =

>>> to the list?=C2=A0 That would help any new participants as well. If the=
y have =

>>> already been discussed please point me to the thread.
>> =

>> I proposed moving away from the metasocket architecture last summer:
>> https://lists.01.org/pipermail/mptcp/2017-July/000064.html
>> =

>> When I reviewed the multipath-tcp.org implementation of MPTCP, my =

>> assessment was (and is) that using metasockets resulted in more intrusiv=
e =

>> code changes for TCP. The more partitioned approach of KCM and RDS (usin=
g =

>> internal kernel sockets) shows an example of in-kernel features that the =

>> maintainers have merged. The approach seemed feasible and I proposed it =
as =

>> a direction to go.
> Thanks for pointing the thread out. That was a proposal we never agreed o=
n =

> it=C2=A0 ?

Yes, I think it's accurate to call it a proposal. The discussion trailed =

off without any specific objection to or endorsement of the metasocket =

point.

> Here is my response to it.
>
> """""
> I agree with the above approach but want to expand on the initial goal.
>
> Our initial goal must be to put a minimal (bare bones) MPTCP implementati=
on =

> in main stream Linux. That could mean no fancy scheduling schemes, just =

> simple round robin or just active/standby. Implementing minimal MPTCP =

> functionality will pretty much expose how main TCP code will be impacted.=
 Any =

> future work to add features will be confined to changes within MPTCP and =

> should not be a concern right now. Such an implementation will also be fu=
lly =

> RFC compliant.
>
> I agree with you that upstream folks would want an opt-in option. I am in =

> favor of a completely different socket family as that would leave tcp soc=
ket =

> code untouched. However we should talk to upstream folks once again.
>
> I should have been more specific, I was referring to the socket layer =

> changes. Now that I have implemented MPTCP on Linux and understand the de=
sign =

> better I don't think using a separate
>
> I would like us to use as much code as possible from the current =

> implementation. In fact if for some reason (I don't see one) we can not s=
hip =

> a minimal implementation than I prefer that we just port the current =

> implementation and worry about architectural issues later.
>
> In short, I would like our focus to be on putting a minimal MPTCP =

> implementation in Linux so that we have a stake in the ground. Performanc=
e =

> and Features can come later. That does not mean that the quality of our =

> implementation is so bad that it is unusable.
>
> Shoaib
>
> """"""""""""""
>
> I was OK using KCM or a different socket family, but nothing else, as I s=
ay =

> using a socket family would only save changes to the socket code.

Ok - appreciate the clarification.

>
> Since our initial goal was not adhered to and I have had more experience,
> I would like a technical analysis or better yet an implementation that su=
pports =

> the said claims. Any mention of upstream should have pointers to the emai=
l =

> threads or should not be used.

I think what people seem to agree on is that an initial upstreamable =

implementation will function with a minimal feature set. My understanding =

is that we have yet to settle on what the steps are to get to that goal, =

and we're working to agree on the steps.

> KCM and RDS are completely different, they do =

> not add options to TCP header or deal with TCP state machine.

I completely agree that they aren't just like MPTCP! And that MPTCP is =

harder to integrate because of exactly the reasons you mention. My =

intent was to point to them as kernel-internal users of TCP with some =

limited design parallels that we can learn from.

>
> I have submitted a patch that provides a complete working implementation =

> based on the current design. It can be used as a reference to point out h=
ow =

> the proposed solution would be better.
>
>> =

>>> It will also help if it can be made clear how these changes will =

>>> expedite implementation of a basic MPTCP implementation. I believe =

>>> that is the current goal, but my understanding may be incorrect.
>> =

>> I think it will expedite upstreaming in the sense that metasockets would =

>> never get merged upstream, and that a more partitioned approach with =

>> dedicated subflow sockets has a reasonable shot. That's my opinion based=
 on =

>> what I've seen from the maintainers (in terms of mailing list discussion=
s, =

>> conversations, and what they have merged in the past).
>> =

>> Now, Christoph has raised the topic for more detailed discussion with =

>> regard to the specifics of the multipath-tcp.org implementation. I don't =

>> think anything is a foregone conclusion in terms of this aspect of the =

>> upstreaming project, you can propose a different approach to discuss.
> I want to point out that folks propose a lot of enhancements on Netdev an=
d =

> IETF with valid uses cases. 99.99% get rejected. There has to be very val=
id =

> reasons -- We are not going to build a kitchen sink of options that will =
make =

> the design complex and unmaintainable. If a vendor has certain requiremen=
ts =

> they need to provide us a list that we evaluate and find out the best way=
 to =

> implement it if we choose to. We are not there yet and talking about any =
kind =

> of options is premature.

To me, the socket-layer changes brought up for discussion are first and =

foremost about modifying the design and architecture of MPTCP to reduce =

the impact on the TCP code. I haven't seen that anyone is putting current =

development effort toward adding bells & whistles - some topics came up =

about possible future APIs that might fit well (like exposing additional =

fds), but I don't see those as in-scope for initial upstreaming.

Part of what we discussed at the last meeting was using a wiki to better =

document what's going on in our MPTCP upstreaming community, I think that =

will do a lot to communicate where contributors are putting their current =

efforts and also help keep track of ideas for the future.


Regards,

--
Mat Martineau
Intel OTC

--===============1151898148862584156==--
