Content-Type: multipart/mixed; boundary="===============0890549958363608375=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/4] bpf: add MPTCP subflow support
Date: Tue, 04 Aug 2020 18:13:27 +0200
Message-ID: <20200804161331.1219161-1-nicolas.rybowski@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5466

--===============0890549958363608375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously it was not possible to make a distinction between plain TCP
sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.

This patch series now enables a fine control of subflow sockets. In its
current state, it allows to put different sockops on each subflow from a
same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
BPF programs.

It should also be the basis of exposing MPTCP-specific fields through BPF.

There is still an open question on patch 3, any comment is welcome.

Nicolas Rybowski (4):
  bpf: expose is_mptcp flag to bpf_tcp_sock
  mptcp: attach subflow socket to parent cgroup
  mptcp: moving struct definitions
  bpf: adding 'bpf_mptcp_sock' structure and helper

 include/linux/bpf.h            |  33 +++++++++
 include/net/mptcp.h            | 132 +++++++++++++++++++++++++++++++++
 include/uapi/linux/bpf.h       |  14 ++++
 kernel/bpf/verifier.c          |  30 ++++++++
 net/core/filter.c              |  76 ++++++++++++++++++-
 net/mptcp/protocol.h           | 123 ------------------------------
 net/mptcp/subflow.c            |  25 +++++++
 scripts/bpf_helpers_doc.py     |   2 +
 tools/include/uapi/linux/bpf.h |  14 ++++
 9 files changed, 325 insertions(+), 124 deletions(-)

-- =

2.28.0

--===============0890549958363608375==--
