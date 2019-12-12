Content-Type: multipart/mixed; boundary="===============2544680211093875505=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove version field from
 subflow_request_sock
Date: Thu, 12 Dec 2019 23:29:30 +0100
Message-ID: <436ce10c-a798-7994-98f5-afc297b56c90@tessares.net>
In-Reply-To: 20191212045521.13499-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2900

--===============2544680211093875505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 12/12/2019 05:55, Peter Krystad wrote:
> This field is not used. Version checking is performed in
> mptcp_parse_options().
> =

> squashto: Create SUBFLOW socket for incoming connections

Thank you for the patch and the review!

- 24201a067136: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections"
- 222ce475568a: conflict in t/mptcp-Add-key-generation-and-token-tree
- 3f97d6a7010d: conflict in =

t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
- bc5f2367d3e2: conflict in t/mptcp-process-MP_CAPABLE-data-option
- bc5f2367d3e2: conflict in t/mptcp-process-MP_CAPABLE-data-option
- 55f1d621d32b..c5b8ad49fc3a: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2544680211093875505==--
