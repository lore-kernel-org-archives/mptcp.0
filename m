Content-Type: multipart/mixed; boundary="===============0994494366724657131=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4] mptcp: fix option length of mp_capable syn/ack
Date: Fri, 06 Dec 2019 17:13:39 +0100
Message-ID: <f921f034-33a7-7460-cc85-8e82f1b673f4@tessares.net>
In-Reply-To: 3879c4d2c681483d5549f4662b058d69bcd402e3.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2824

--===============0994494366724657131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Peter,

On 05/12/2019 19:14, Peter Krystad wrote:
> =

> Looks good.

Thank you for the new version and the review!

- 40c5aac59cf7: "squashed" part 1 in "mptcp: Handle MPTCP TCP options"
- 29710f885028: "Signed-off-by" + "Co-developed-by"
- 36e93ae12137: "squashed" part 2 in "mptcp: Create SUBFLOW socket for =

incoming connections"
- cab89c119b1c: conflict in =

t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
- in this commit, for mptcp_synack_options(), only this change was left =

over:

=3D=3D=3D

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 701b6243c377..da94c263197a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -476,7 +476,7 @@ bool mptcp_synack_options(const struct request_sock =

*req, unsigned int *size,
                 opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
                 opts->sndr_key =3D subflow_req->local_key;
                 *size =3D TCPOLEN_MPTCP_MPC_SYNACK;
-               pr_debug("subflow_req=3D%p, local_key=3D%llu",
+               pr_debug("req=3D%p, local_key=3D%llu",
                          subflow_req, subflow_req->local_key);
                 return true;
         }

=3D=3D=3D

I then undo this change. That's also the only change we can see as a =

result (as expected): 7e9aa2a662bf..7c57362bfddb

Tests and re-creation of the 'export' branch is in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0994494366724657131==--
