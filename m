Content-Type: multipart/mixed; boundary="===============8172044810954090720=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Commit text change: Handle MPTCP TCP options
Date: Mon, 20 Jan 2020 17:14:22 +0100
Message-ID: <70cffe68-4544-ca05-0f3d-d166b58e47b1@tessares.net>
In-Reply-To: 49ba804f999b7f4907ab585ee456fd386f67bd8a.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3431

--===============8172044810954090720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 18/01/2020 02:24, Peter Krystad wrote:
> =

> Would like to change the commit text to:
>      =

> Add hooks to parse and format the MP_CAPABLE option.
> =

> This option is handled according to MPTCP version 0 (RFC6824).
> MPTCP version 1 MP_CAPABLE (RFC6824bis/RFC8684) will be added
> later in coordination with related code changes.

Thank you for this new version of the commit message!

- fbc4fbbe1b40: fix in t/mptcp-Handle-MPTCP-TCP-options


=3D=3D=3D
diff --git a/.topmsg b/.topmsg
index fa4ab165bfbc..4fe41b754dea 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,11 +1,11 @@
  From: Peter Krystad <peter.krystad(a)linux.intel.com>
  Subject: [PATCH] mptcp: Handle MPTCP TCP options

-Add routines to parse and format the MP_CAPABLE option.
+Add hooks to parse and format the MP_CAPABLE option.

-These options are handled according to MPTCPv0 (RFC6824).
-RFC6824bis/RFC8684 MPTCPv1 MP_CAPABLE is added later in coordination
-with related code changes.
+This option is handled according to MPTCP version 0 (RFC6824).
+MPTCP version 1 MP_CAPABLE (RFC6824bis/RFC8684) will be added later in
+coordination with related code changes.

  Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
  Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
=3D=3D=3D


Export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8172044810954090720==--
