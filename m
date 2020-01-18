Content-Type: multipart/mixed; boundary="===============6578836813900228833=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Commit text change: Handle MPTCP TCP options
Date: Fri, 17 Jan 2020 17:24:30 -0800
Message-ID: <49ba804f999b7f4907ab585ee456fd386f67bd8a.camel@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3419

--===============6578836813900228833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Would like to change the commit text to:
    =

Add hooks to parse and format the MP_CAPABLE option.

This option is handled according to MPTCP version 0 (RFC6824).
MPTCP version 1 MP_CAPABLE (RFC6824bis/RFC8684) will be added
later in coordination with related code changes.
    =


Previous:

Add routines to parse and format the MP_CAPABLE option.
    =

These options are handled according to MPTCPv0 (RFC6824).
RFC6824bis/RFC8684 MPTCPv1 MP_CAPABLE is added later in coordination
with related code changes.

Peter.

--===============6578836813900228833==--
