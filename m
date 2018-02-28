Content-Type: multipart/mixed; boundary="===============6009693449968119329=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Wed, 28 Feb 2018 15:44:39 -0800
Message-ID: <alpine.OSX.2.21.1802281518590.20016@mjmartin-mac01.sea.intel.com>
In-Reply-To: 20180228230805.GL2038@MacBook-Pro-4.local
X-Status: 
X-Keywords:                  
X-UID: 327

--===============6009693449968119329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2018, Christoph Paasch wrote:

> On 27/02/18 - 10:50:38, Mat Martineau wrote:
>>
>> Hi Christoph,
>>
>> On Mon, 26 Feb 2018, Christoph Paasch wrote:
>>
>>> Hello,
>>>
>>> as for next steps after the submission of the TCP-option framework to n=
etdev
>>> and DaveM's feedback on it.
>>>
>>> Even if the submission got rejected, I think we still have a very usefu=
l set
>>> of patches here. The need for a framework might pop up again in the fut=
ure,
>>> and so these patches could come in handy.
>>> Mat, maybe you can put our latest submission on your kernel.org-git repo
>>> just so that we don't lose track of these patches?
>>
>> Done: https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.gi=
t/log/?h=3Dmd5
>
> Thanks!
>
>>> I can also create a github repo if you prefer that.
>>>
>>>
>>> As for DaveM's feedback, the main takeaway - as Mat already noted on hi=
s other
>>> mail - is that fast-path performance he the highest priority. Branching=
 and
>>> indirect function calls are hardly accepted there.
>>>
>>>
>>> So, in that spirit I think we need to work towards reducing MPTCP's
>>> intrusiveness to the TCP stack.
>>>
>>> * Stop taking meta-lock when receiving subflow data (all the changes wh=
ere
>>>  we check for mptcp(tp) and then do bh_lock_sock(meta_sk)).
>>>  The reason we do this in today's implementation is because it allows to
>>>  access the meta data-structure at any point. If we stop taking the
>>>  meta-lock a few things need to change:
>>>  1. Do lockless accesses for selected fields (e.g., for the DATA_ACK).
>>>  2. Group the more intrusive accesses to few select points in the TCP-s=
tack
>>>     where we then take the meta-lock (e.g., when receiving data).
>>>     (this would be equivalent as if the TCP-option framework would be t=
here
>>>     - thus we need to move code to these or similar points in the stack)
>>>  3. Sometimes schedule work-queues when we need to avoid deadlocks due =
to
>>>     lock-ordering issues (e.g., when we can't take the meta-lock because
>>>     it's already held by another thread).
>>>
>>>  I think, the way to approach this here, is by working iteratively and =
start
>>>  moving code in such a way that accesses to the meta-socket are grouped
>>>  together.
>>>
>>>  Also, we have a few callbacks that we added (cfr., struct tcp_sock_ops=
).
>>>  We added them to avoid duplicating the code. Let's review those and se=
e if
>>>  we can get rid of them. (as an example: .send_fin could be removed as =
it is only
>>>  called from tcp_shutdown, called from the .shutdown callback in tcp_pr=
ot -
>>>  thus if we expose a separate MPTCP socket-type with its own struct pro=
to,
>>>  we can get rid of the .send_fin callback)
>>>
>>
>> I think a separate MPTCP socket type will be important for upstream
>> acceptance. My team has been working on some code with this separate soc=
ket
>> type that we can share.
>
> Great! I would love to move MPTCP to a separate socket-type.
>
>> I'm thinking that it will be useful to share once a
>> connection can stay up without falling back to TCP.
>
> Hmm... I'm not sure I understand. What do you mean with "connection can s=
tay
> up without falling back to TCP".

Sorry, to clarify:

The code I have today does not process incoming DSS options or send a =

data ack, so the connection falls back to regular TCP after a couple of =

packets. It's based on net-next.

I would like to get my code to a point where it sends a correct data ack =

so the connection does not fall back, and at that point post the code on =

git.kernel.org and as a patch set on this list.

>>
>>> * Investigate how/if we can make MPTCP adopt KCM or ULP.
>>
>> My main concern about ULP is that only one upper layer protocol can be s=
et
>> up (at least as the code is now), so you wouldn't be able to do something
>> like use in-kernel TLS over MPTCP. Other than that, it seems like a natu=
ral
>> fit for MPTCP.
>
> Do you think it would be feasible to make ULP use multiple ULPs ?

I think it's possible to have a layered approach to ULP, maybe by =

providing a list of protocols to setsockopt. It would be nice to have some =

infrastructure to help implement it correctly, rather than depending on =

each ULP to correctly call in to the layer below it whether it's the =

"normal" TCP code or some other ULP. The combinatorics would be a headache =

for sure: running TLS over an MPTCP connection makes sense, but MPTCP =

layered on top of TLS doesn't make sense. At least if all the protocols =

were specified in one setsockopt we could limit which combinations are =

allowed.

>>
>> So far I've been looking at KCM as a source of good ideas rather than
>> something we could use directly. KCM uses SOCK_SEQPACKET or SOCK_DGRAM, =
but
>> maybe it could be extended to include SOCK_STREAM. Where MPTCP places DSS
>> mappings in the TCP options, KCM handles message boundaries within the d=
ata
>> stream - that made me ponder using XDP to place the DSS mappings in the =
data
>> payload (with the necessary TCP sequence number adjustments). I'm not su=
re
>> it's workable because it can be expensive to change the length of an
>> incoming skb and adjusting the acks gets complicated, but it's at least =
an
>> interesting thought experiment :)
>>
>>> * There is still the open question of the API, path-management,... Tess=
ares
>>>  has some experience with that, so maybe they can provide some ideas he=
re.
>>
>> We (at OTC) are working on a generic netlink proposal for path managemen=
t as
>> well.
>>
>>>
>>> * The size of the skb. Well, we have been discussing this for quite a w=
hile :)
>>>  One option is always to have a lookup table as they do for the
>>>  TLS-records. That will hurt performance, but at least it's a step forw=
ard.
>>>  And we have a bunch of other ideas that might be worth exploring as we=
ll.
>>>  If I'm not mistaken, Rao had an approach that could work as well, righ=
t?
>>
>> This is what I'm working on now. For outgoing packets, I have a way to
>> optionally allocate sk_buffs with extra control block space. For incoming
>> packets, my initial experiment is with preventing packet coalesce/collap=
se
>> so TCP options are still in the skb headroom. I don't consider that a
>> long-term solution, though. Some kind of lookup table will probably be
>> needed.
>>
>>> Any other comments, suggestions,...? :-)
>>
>> I had these thoughts on evolving the multipath-tcp.org kernel fork last
>> summer (excerpt from
>> https://lists.01.org/pipermail/mptcp/2017-July/000064.html), which I thi=
nk
>> are still relevant:
>>
>> """
>>
>> One approach is to attempt to merge the multipath-tcp.org fork. This is =
an
>> implementation in which the multipath-tcp.org community has invested a l=
ot
>> of time and effort, and it is in production for major applications (see
>> https://tools.ietf.org/html/rfc8041). This is a tremendous amount of cod=
e to
>> review at once (even separating out modules), and currently doesn't fit =
with
>> what the maintainers have asked for (non-intrusive, sk_buff size, MPTCP =
by
>> default). I don't think the maintainers would consider merging such an
>> extensive piece of git history, especially where there are a fair number=
 of
>> commits without an "mptcp:" label on the subject line or without a DCO
>> signoff (https://www.kernel.org/doc/html/latest/process/submitting-patch=
es.html#sign-your-work-the-developer-s-certificate-of-origin).
>> Today, the fork is at kernel v4.4 and current upstream development is at
>> v4.13-rc1, so the fork would have to catch up and stay current. (2018 no=
te:
>> Christoph has merged up to more recent kernels now)
>>
>> The other extreme is to rewrite from scratch. This would allow increment=
al
>> development with maintainer review from the start, but doesn't take
>> advantage of existing code.
>>
>> The most realistic approach is somewhere in between, where we write new
>> code that fits maintainer expectations and utilize components from the
>> fork where licensing allows and the code fits. We'll have to find the
>> right balance: over-reliance on new code could take extra time, but
>> constantly reworking the fork and keeping it up-to-date with net-next is
>> also a lot of overhead.
>>
>> """
>>
>> Gregory and Matthieu, do you have any thoughts on where the right balanc=
e is
>> on evolving the fork vs. adding new code?
>>
>>
>>> On my side, as a first concrete step, I will work towards lockless subf=
low
>>> establishment. In tcp_v4_rcv, we are currently taking the meta-level lo=
ck
>>> when the socket-lookup matches on a request-socket. Now that TCP suppor=
ts
>>> lockless listeners, MPTCP should do that as well.
>>
>> I'll work on getting my team's MPTCP socket type code posted to
>> git.kernel.org, and getting our generic netlink proposal posted to this
>> list.
>
> Cool! I think, the MPTCP socket-type code should also find its way into
> mptcp-dev. It would allow to move that one forward as well.

Thanks. It's a fairly deep change from the metasocket architecture, so we =

will see how it works out.

--
Mat Martineau
Intel OTC

--===============6009693449968119329==--
