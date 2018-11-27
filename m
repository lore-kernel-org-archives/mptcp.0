Content-Type: multipart/mixed; boundary="===============8002617968089878769=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] New skb extension proposal on netdev
Date: Tue, 27 Nov 2018 09:57:14 -0800
Message-ID: <20181127175714.GP3611@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1811261635380.9846@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 842

--===============8002617968089878769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+Florian

On 26/11/18 - 16:49:54, Mat Martineau wrote:
> =

> Florian posted a skb extension patch set on netdev today and I wanted to
> have folks here take a look:
> =

> https://marc.info/?l=3Dlinux-netdev&m=3D154323251731893&w=3D2
> =

> So far, I really like how it solves the problem of making extension space
> available to multiple layers.
> =

> To give more context for the netdev discussion (and to see if others want=
 to
> add to it):
> =

> =

> The MPTCP control block in our upstream proposal branch looks like this:
> =

> struct mptcp_skb_cb {
>         u64             data_ack;
> =

>         /* DSS mapping */
>         u64             data_seq;
>         u32             subflow_seq;
>         u16             dll;
>         __sum16         checksum;
>         u8              use_map:1,
>                         dsn64:1,
>                         use_checksum:1,
>                         data_fin:1,
>                         use_ack:1,
>                         ack64:1,
>                         __unused:2;
> };
> =

> This is the content of the MPTCP DSS option that needs to propagate from
> the TCP headers to the MPTCP upper layer (and vice versa). The DSS mapping
> is used to establish where a part of the TCP sequence space belongs in the
> 64-bit MPTCP sequence space. This can be included in any data packet, or
> as little as once per 2^16 bytes of data.
> =

> =

> The approaches we've tried already are the skb_shared_info technique
> mentioned in Florian's cover letter, and a variation on Eric's suggestion
> (to add a non-initialized area to sk_buff_fclones). I guess we misunderst=
ood
> where Eric wanted to put that data - I built an skb extension using an
> uninitialized area in sk_buff. Neither of these handled the issue of shar=
ing
> the extension bytes, which Florian's patch does. Sharing that space makes=
 it
> usable for other purposes (sp, nf_bridge, kTLS).
> =

> =

> I need to finish looking over the patch set, but so far I think it's a go=
od
> fit for MPTCP and other uses.

Yes, the patches look quite good to me for the MPTCP use-case!


Florian, would kTLS also be a possible candidate for this? Because, it is
doing upcalls from skb->sk to get the tls-context and TLS-records (see
mlx5e_tls_handle_tx_skb()).

TLS-records are very similar to what MPTCP's DSS-mapping needs, which is
basically mapping every byte in the TCP-subflow's sequence space to a
sequence number at the MPTCP-level (in rough terms that's what TLS records
do as well).


Let's discuss on Thursday!


Christoph


> =

> =

> Thanks,
> =

> --
> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============8002617968089878769==--
