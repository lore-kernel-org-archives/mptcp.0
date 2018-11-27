Content-Type: multipart/mixed; boundary="===============6636622315260347652=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] New skb extension proposal on netdev
Date: Mon, 26 Nov 2018 16:49:54 -0800
Message-ID: <alpine.OSX.2.21.1811261635380.9846@mjmartin-mac01.sea.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 841

--===============6636622315260347652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Florian posted a skb extension patch set on netdev today and I wanted to =

have folks here take a look:

https://marc.info/?l=3Dlinux-netdev&m=3D154323251731893&w=3D2

So far, I really like how it solves the problem of making extension space =

available to multiple layers.

To give more context for the netdev discussion (and to see if others want =

to add to it):


The MPTCP control block in our upstream proposal branch looks like this:

struct mptcp_skb_cb {
         u64             data_ack;

         /* DSS mapping */
         u64             data_seq;
         u32             subflow_seq;
         u16             dll;
         __sum16         checksum;
         u8              use_map:1,
                         dsn64:1,
                         use_checksum:1,
                         data_fin:1,
                         use_ack:1,
                         ack64:1,
                         __unused:2;
};

This is the content of the MPTCP DSS option that needs to propagate from
the TCP headers to the MPTCP upper layer (and vice versa). The DSS mapping
is used to establish where a part of the TCP sequence space belongs in the
64-bit MPTCP sequence space. This can be included in any data packet, or
as little as once per 2^16 bytes of data.


The approaches we've tried already are the skb_shared_info technique =

mentioned in Florian's cover letter, and a variation on Eric's suggestion =

(to add a non-initialized area to sk_buff_fclones). I guess we =

misunderstood where Eric wanted to put that data - I built an skb =

extension using an uninitialized area in sk_buff. Neither of these handled =

the issue of sharing the extension bytes, which Florian's patch does. =

Sharing that space makes it usable for other purposes (sp, nf_bridge, =

kTLS).


I need to finish looking over the patch set, but so far I think it's a =

good fit for MPTCP and other uses.


Thanks,

--
Mat Martineau
Intel OTC

--===============6636622315260347652==--
