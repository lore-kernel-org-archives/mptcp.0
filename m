Content-Type: multipart/mixed; boundary="===============1951808523041983709=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Questions about DSS checksum
Date: Tue, 23 Feb 2021 20:29:52 +0800
Message-ID: <CA+WQbwuOcOWiHWtwsVU2r-K2P7jGpbL-q8sBH1juGwBki7gpzQ@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7921

--===============1951808523041983709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to solve the issues 134, I'm reading the mptcp.org (branch:
mptcp_v0.95) source code about DSS checksum implementation recently but I
didn't understand it very well.

Here's my first question.

On the outgoing path (net/mptcp/mptcp_output.c), the function
mptcp_write_dss_mapping(), use the following code to generate the checksum
value and write it in the DSS option:

        if (tp->mpcb->dss_csum && data_len) {
                __sum16 *p16 =3D (__sum16 *)ptr;
                __be32 hdseq =3D mptcp_get_highorder_sndbits(skb, tp->mpcb);
                __wsum csum;

                *ptr =3D htonl(((data_len) << 16) |
                             (TCPOPT_EOL << 8) |
                             (TCPOPT_EOL));
                csum =3D csum_partial(ptr - 2, 12, skb->csum);
                p16++;
                *p16++ =3D csum_fold(csum_partial(&hdseq, sizeof(hdseq), cs=
um));
        } else {

On the incoming path (net/mptcp/mptcp_input.c), the function
mptcp_parse_options, use the following code to parse MPTCP_SUB_DSS:

                if (mdss->M) {
                        if (mdss->m) {
                                u64 data_seq64 =3D get_unaligned_be64(ptr);

                                tcb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
                                mopt->data_seq =3D (u32) data_seq64;

                                ptr +=3D 12; /* 64-bit dseq + subseq */
                        } else {
                                mopt->data_seq =3D get_unaligned_be32(ptr);
                                ptr +=3D 8; /* 32-bit dseq + subseq */
                        }
                        mopt->data_len =3D get_unaligned_be16(ptr);

                        tcb->mptcp_flags |=3D MPTCPHDR_SEQ;

                        /* Is a check-sum present? */
                        if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1))
                                tcb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;

                        /* DATA_FIN only possible with DSS-mapping */
                        if (mdss->F)
                                tcb->mptcp_flags |=3D MPTCPHDR_FIN;
                }

Here it just sets the MPTCPHDR_DSS_CSUM flag, it doesn't read the checksum
value from the DSS option. So my first question is: How dose it read the va=
lue
of the checksum in DSS option on the incoming path?

Please give me some help for it. Thanks.

-Geliang
--===============1951808523041983709==--
