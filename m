Content-Type: multipart/mixed; boundary="===============3130549606110525178=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
Date: Fri, 21 Aug 2020 17:15:38 +0200
Message-ID: <20200821151544.1211989-1-nicolas.rybowski@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5592

--===============3130549606110525178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously it was not possible to make a distinction between plain TCP
sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.

This patch series now enables a fine control of subflow sockets. In its
current state, it allows to put different sockopt on each subflow from a
same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
BPF programs.

It should also be the basis of exposing MPTCP-specific fields through BPF.

Nicolas Rybowski (3):
  bpf: expose is_mptcp flag to bpf_tcp_sock
  mptcp: attach subflow socket to parent cgroup
  bpf: add 'bpf_mptcp_sock' structure and helper

 include/linux/bpf.h            | 33 ++++++++++++++++
 include/uapi/linux/bpf.h       | 14 +++++++
 kernel/bpf/verifier.c          | 30 ++++++++++++++
 net/core/filter.c              | 13 +++++-
 net/mptcp/Makefile             |  2 +
 net/mptcp/bpf.c                | 72 ++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c            | 27 +++++++++++++
 scripts/bpf_helpers_doc.py     |  2 +
 tools/include/uapi/linux/bpf.h | 14 +++++++
 9 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/bpf.c

-- =

2.28.0

--===============3130549606110525178==--
