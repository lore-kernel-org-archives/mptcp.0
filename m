Content-Type: multipart/mixed; boundary="===============6733415750854629992=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status
Date: Tue, 03 Oct 2017 23:22:21 -0700
Message-ID: <20171004062221.GE4897@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1710031442470.15575@jrschiff-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 108

--===============6733415750854629992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/10/17 - 17:22:23, Mat Martineau wrote:
> =

> On Tue, 3 Oct 2017, Christoph Paasch wrote:
> =

> > On 03/10/17 - 12:26:22, Mat Martineau wrote:
> > > =

> > > On Mon, 2 Oct 2017, Christoph Paasch wrote:
> > > =

> > > > Hello Mat,
> > > > =

> > > > On 02/10/17 - 16:00:56, Mat Martineau wrote:
> > > > > On Mon, 2 Oct 2017, Christoph Paasch wrote:
> > > > =

> > > > > > I keep on moving mptcp_trunk upwards to track upstream Linux. C=
urrently I'm
> > > > > > stuck at v4.9 (there is a nasty bug that popped up with the mer=
ge and I
> > > > > > wasn't able to fix that yet).
> > > > > > =

> > > > > > =

> > > > > > The merge with v4.9 also forced me to bump skb->cb to 80 bytes.=
.. :/
> > > > > > I have been thinking back and forth on how we could handle this=
. The best
> > > > > > way I see at the moment is to create a scratch-area at the end =
of the skb's
> > > > > > data (like skb_shared_info). I think it also would quite nicely=
 fit with a
> > > > > > KCM/ULP-style architecture where we could have a BPF-program th=
at does the
> > > > > > scheduling.
> > > > > > I haven't dived very deep into the skb->cb problem yet.
> > > > > > =

> > > > > =

> > > > > I don't think we're the first ones to want more control block byt=
es, seems
> > > > > like finding a solution would help outside of MPTCP too. I've loo=
ked at
> > > > > skb_tailroom_reserve a little bit, and also given some preliminar=
y thought
> > > > > to stashing header info in skb_shared_info->frags (maybe by creat=
ing "header
> > > > > fragments").
> > > > =

> > > > =

> > > > =

> > > > Yes, I also have to look a bit more at tailroom_reserve.
> > > > =

> > > > Can you elaborate a bit more on the "header fragments" ?
> > > =

> > > The idea is to modify struct skb_frag_struct to represent different t=
ypes of
> > > fragments by making the page pointer a union and providing a way to d=
etect
> > > the difference (size =3D=3D 0?). In addition to pages of payload, it =
could also
> > > point to other types of content, like header information, that would =
be
> > > ignored as payload but available for other use like a pre-populated T=
CP
> > > option.
> > =

> > What if instead of using struct skb_frag_struct, we just add a field to
> > struct skb_shared_info? It should not be as restricted wrt to adding fi=
elds
> > as is struct sk_buff, no?
> > =

> =

> I've been assuming that the resistance to increasing the size of sk_buff
> would also apply to skb_shared_info since you end up with larger allocati=
ons
> for every skb either way. The impact of a larger skb_shared_info is spread
> across any clones, so it's not as bad as changing sk_buff, but it's still=
 an
> increase.
> =

> However, a larger skb_shared_info could be *optional* if we defined a new
> SKB_ALLOC_SHARED_CB flag to pass to __alloc_skb. We get a bunch of space =
to
> play with and everyone else gets the same size structs and allocations th=
at
> they're used to.

I like that!

> =

> > > A downside is that this would involve making sure that every user of =
the skb
> > > frags array understands what's up, which would touch a lot of driver =
code.
> > =

> > True, this would impact a big code base and could be error-prone.
> > =

> > > =

> > > > =

> > > > At one point, I had a more or less crazy idea of storing it inside =
the
> > > > payload.
> > > > =

> > > > Here was my train of thought:
> > > > =

> > > > Basically, the big problem with MPTCP (ignoring implementations) is=
 that the
> > > > IETF decided to put the DSS-option in the TCP option-space. Thus, t=
his
> > > > inherintly links a TCP-option with the payload of the packet (due t=
o the
> > > > DSS-mapping).
> > > > Such linking is bad, for TSO, LRO/GRO, middleboxes splitting segmen=
ts,...
> > > > =

> > > > It would have been much better if the IETF would have placed the DS=
S-option
> > > > (not the DATA_ACK) in the payload and leave the TCP-options just fo=
r truly
> > > > signalling options (DATA_ACK, ADD_ADDR, REMOVE_ADDR, MP_PRIO,...).
> > > =

> > > Agreed!
> > > =

> > > > So, I was thinking that we could fake this and the MPTCP-level woul=
d do a
> > > > regular tcp_sendmsg on the subsockets with the DSS-mapping as part =
of the
> > > > payload. It would also just pass a flag down to tcp_sendmsg, that i=
ndicates
> > > > that the payload contains a DSS-mapping. This flag would then be st=
ored in
> > > > the relevant skb (just one bit - I think we have that space).
> > > > =

> > > > Then, later in tcp_options_write, we just need to check on that fla=
g and
> > > > extract the DSS-mapping and write it into the TCP header space (and=
 adjust
> > > > skb->data,...).
> > > > =

> > > > =

> > > > In principle, I think this would have been very clean IMO.
> > > > =

> > > > =

> > > > But it doesn't work, because this DSS-mapping will no be accounted =
in TCP's
> > > > sequence space (aka., snd_nxt,...) but in the end it won't be sent =
out. So,
> > > > that would screw up TCP completly. Basically, skb->len will include=
 the
> > > > DSS-mapping in the payload but it won't be sent out as part of the =
payload
> > > > but as part of the TCP option-space.
> > > > =

> > > > So, because of this I gave up on this avenue.
> > > > =

> > > > If you think this could work in another way or something like that,=
 let me
> > > > know :)
> > > =

> > > I've been looking at a very similar approach, pre-populating the DSS =
option
> > > and setting a flag telling tcp_options_write to use those option byte=
s as-is
> > > and build the rest of the TCP header before it.
> > =

> > These pre-populated bytes would be sitting in the linear part of the me=
mory
> > above skb->data ?
> =

> By "above" I'm not sure if you mean "in the headroom between skb->head and
> skb->data" or "starting at skb->data". The latter is what I intended:
> skb->data points to the option kind byte.

I meant, in the headroom between skb->head and skb->data.

Putting it below skb->data was what I had envisioned in my original e-mail
here. But that has other side-effects (see below at [1]).

> =

> > =

> > We had a similar approach prior to switching to the tcp_skb_cb->dss mode
> > (which was done by Octavian). I detailled this old approach in my thesis
> > (https://inl.info.ucl.ac.be/system/files/phd-thesis_1.pdf), starting at=
 page
> > 101.
> > =

> > =

> > I just reread what the issue was and the problem was that pskb_copy()
> > would then not copy the DSS-option. So, before every call to pskb_copy(=
) in
> > the TCP-stack we were adjusting skb->data and skb->len to make sure tha=
t it
> > all got taken care of.
> =

> I've re-read that now as well, and it sounds like I am reinventing the ol=
der
> v0.88 approach that has various corner cases but not the pksb_copy proble=
m.
> Unfortunately it sounds like it was complicated in practice!
> =

> > Now, if we can handle this cleaner in pskb_copy() we could go back to w=
hat
> > we had before. I think we just need to store in the skb how much data is
> > sitting on top of skb->data that needs to be copied as well. And then w=
e are
> > good to go IMO.
> =

> Another variation is to have a "copy_headroom" bit in sk_buff that makes
> pskb_copy copy everything from skb->head to skb->tail. But I like the
> SKB_ALLOC_SHARED_CB idea better.

Agreed, SKB_ALLOC_SHARED_CB looks good to me. It's very generic and can be
used later on by other protocols,...

> =

> > > The TCP sequence numbers
> > > could also detect the prepopulated header and account for it.
> > =

> > I'm not sure what you mean by that. How would the sequence numbers acco=
unt
> > for the prepopulated header?
> =

> I didn't phrase that well, my apologies. If the TCP option was prepopulat=
ed
> at skb->data, the current TCP code would see it as part of the payload. T=
he
> code doing the TCP sequence number assignment would have to know the actu=
al
> TCP payload length in order to set the sequence numbers correctly in the
> header.

[1]

Would you then set skb->len so that it includes the TCP-option starting at
skb->data? I guess you have to, because otherwise functions like
__pskb_trim_head() (called from tcp_trim_head()) will have problems.

That would mean that the TCP-stack can't use skb->len anymore in its
output path. Making sure that this still works would be very tricky I think.



From what I see, the SKB_ALLOC_SHARED_CB approach seems to me the most
promising and generic. Let's try to aim for this.

Do you have cycles to investigate this approach?


Christoph



> =

> > > I don't think
> > > this has the problem you identified since all of the skb payload is s=
ent.
> > > Maybe this doesn't play nice with cloned skbs (which can't modify the
> > > payload), but doesn't the mapping need to stay the same if it's
> > > retransmitted?
> > =

> > Yes, it must stay the same. Otherwise there will be trouble with the
> > DSS-csum.
> > =

> > But it does not need to be on all segments that are covered by the mapp=
ing.
> > Meaning, if we split an skb thanks to an incoming SACK-block or a parti=
al ACK,
> > we don't have to make sure that the new skb has the DSS-option as well.
> > Because part of it has been ack'd (or sack'd) and thus the receiver got
> > the DSS-option.
> =

> Regards,
> =

> --
> Mat Martineau
> Intel OTC

--===============6733415750854629992==--
