Content-Type: multipart/mixed; boundary="===============5226678074371784827=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] New skb extension proposal on netdev
Date: Wed, 28 Nov 2018 10:01:44 -0800
Message-ID: <alpine.OSX.2.21.1811280903110.16754@kcassens-mobl1.amr.corp.intel.com>
In-Reply-To: 20181128121312.lja2xqlqmpi4hmbn@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 845

--===============5226678074371784827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Florian -

On Wed, 28 Nov 2018, Florian Westphal wrote:

> Christoph Paasch <cpaasch(a)apple.com> wrote:
>> On 26/11/18 - 16:49:54, Mat Martineau wrote:
>>>
>>> Florian posted a skb extension patch set on netdev today and I wanted to
>>> have folks here take a look:
>>>
>>> https://marc.info/?l=3Dlinux-netdev&m=3D154323251731893&w=3D2
>>>
>>> So far, I really like how it solves the problem of making extension spa=
ce
>>> available to multiple layers.
>>>
>>> To give more context for the netdev discussion (and to see if others wa=
nt to
>>> add to it):
>>>
>>>
>>> The MPTCP control block in our upstream proposal branch looks like this:
>
> Which branch is that?
>
> Its not
> https://github.com/multipath-tcp/mptcp_net-next.git master
> and can't see that skb_cb in mptcp_trunk either (plus, that branch
> appears dated...).
>

It's from
https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmptcp-proposal

That's been referenced by the RFC patch sets on the mailing list =

(https://lists.01.org/pipermail/mptcp/2018-October/000763.html) and an =

obscure link in the wiki. Sorry about the lack of discoverability, I'll =

link it in a better place.

The struct there isn't an exact match to the one below because I'm =

finishing up a revision to use mptcp_skb_cb on the receive path (I had =

removed some members that weren't needed on the tx side, but am adding =

them back).

>>> struct mptcp_skb_cb {
>>>         u64             data_ack;
>>>
>>>         /* DSS mapping */
>>>         u64             data_seq;
>>>         u32             subflow_seq;
>>>         u16             dll;
>>>         __sum16         checksum;
>>>         u8              use_map:1,
>>>                         dsn64:1,
>>>                         use_checksum:1,
>>>                         data_fin:1,
>>>                         use_ack:1,
>>>                         ack64:1,
>>>                         __unused:2;
>>> };
>>>
>>> This is the content of the MPTCP DSS option that needs to propagate from
>>> the TCP headers to the MPTCP upper layer (and vice versa). The DSS mapp=
ing
>>> is used to establish where a part of the TCP sequence space belongs in =
the
>>> 64-bit MPTCP sequence space. This can be included in any data packet, or
>>> as little as once per 2^16 bytes of data.
>
> I see, thanks.
> So I guess there is no way to assemble this directly within mptcp (tx
> side) and have tcp stack leave it alone, or have skbs get passed up to
> mptcp on rx so DSS mapping can be done there?

It seemed to be the best available option. While MPTCP allows for DSS =

mappings to be sent early, it works well to send or receive them on the =

packet where the information is needed.

The RFCv3 patch set (link above) used the socket error queue on the rx =

side to pass packets with header data up to the MPTCP layer, but after =

reviewing it on our list we identified some sequencing issues and decided =

to try using the control block instead.

There are other methods this group discussed, like using a per-subflow =

lockless queue (or two) to bypass the TCP stack. An extended control block =

seemed like a less complicated and not-too-invasive approach.

Another twist with using an extra sk_buff control block to get this =

information passed through the TCP stack is that we don't want TCP =

coalesce/collapse to combine skbs in a way that destroys the extended =

information.

> tx+rx distinction is important, as Erics suggestion (fclone cb_ext)
> won't work for rx side, and a new 'extended_shinfo' will likely not fly
> for rx part either.

Agreed.

>>> uninitialized area in sk_buff. Neither of these handled the issue of sh=
aring
>>> the extension bytes, which Florian's patch does. Sharing that space mak=
es it
>>> usable for other purposes (sp, nf_bridge, kTLS).
>
> Yes, although I did not have other in-tree users in mind except sp/ipsec
> and nf_bridge.  As for new users, there isn't anything I see other than
> possible use by MPTCP.  I recall a wifi developer telling me that
> skb->cb is already very small, so maybe they would have another use
> case, but I am not aware of anything at this time.
>

Ok.

>> Florian, would kTLS also be a possible candidate for this? Because, it is
>> doing upcalls from skb->sk to get the tls-context and TLS-records (see
>> mlx5e_tls_handle_tx_skb()).
>
> I don't know enough about (k)TLS to give a good answer.
> Basically the extension-idea is a good fit when all of the following are =
true:
>
> 1. Data is related to the skb/packet aggregate
> 2. Data can (should, must) be freed when the skb is free'd
> 3. Data is to be carried both on RX and TX side
> 4. Data is not going to be relevant for most in-tree users (udp, tcp,
>   forwarding workloads, ...)
> 5. Data is small.  Right now the extension proposal allows an
>   accumulated size of 2k worth of extension data, and we have to assume
>   worst-case (i.e. "nf_bridged mptcp packet traversing ipsec tunnel", so
>   all extensions are in use on same skb.
>
>   Right now there is plenty of space left though and the proposal
>   uses BUILD_BUG_ON to assert that accumulated size doesn't cross the all=
owed
>   thresh.
>
> 6. There are no fancy action(s) needed on clone/free.

MPTCP looks like a good match for all six.

>
> I looked at secpath, it will need to get/put the xfrm states that it
> has pointers to from the 'secpath' struct.
>
> This isn't a show stopper for converting skb->sp to the extension
> infrastructure, as all of the XFRM helpers needed are always builtin,
> but it does prohibit calls to functions that reside in a kernel module.
>
>> TLS-records are very similar to what MPTCP's DSS-mapping needs, which is
>> basically mapping every byte in the TCP-subflow's sequence space to a
>> sequence number at the MPTCP-level (in rough terms that's what TLS recor=
ds
>> do as well).
>
> AFAICS the upcall to fetch sk upper layer protocol data for ktls will
> also need to access data taht doesn't map to the skb, such as the crypto
> context, so it seems to me that this can/should remain in the socket
> context.
>
>> Let's discuss on Thursday!
>
> Yep, I will attend this call, we can discuss this there.
>
> I wanted to avoid a disussion of MPTCP requirements on netdev at this
> stage and only focus on ipsec/bridge and this extension proposal, but
> it would definitely not hurt to have agreement on MPTCP requirements
> wrt. interaction with rest-of-network-stack.
>

Sounds like a good idea, thanks for discussing here.

Regards,

--
Mat Martineau
Intel OTC

--===============5226678074371784827==--
