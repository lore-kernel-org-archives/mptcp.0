Content-Type: multipart/mixed; boundary="===============0891196408084643454=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: refactor xmit path
Date: Mon, 15 Apr 2019 17:30:46 +0200
Message-ID: <cover.1555342070.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1067

--===============0891196408084643454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

his series refactor the mptcp xmit path trying to make sendmsg behavior
more consistent, memory efficent and improve its performances.

The code is also available here:

https://github.com/pabeni/mptcp/tree/mptcp-proposal-devel

To support MP_JOIN and multiple subflows, the idea is adding, with later
patches, an RB-tree structure containing references to the pending page
fragments, their length and the associated mptcp write_seq number (is subfl=
ow
rel_write_seq needed, too?). RB-tree node can be allocated using the same
page frag used in this series for skb data. Each RB-tree node will own a
reference to the page frag.

RFC -> v1:
 - addressed Mat's feedback, dropping patch 3/4 and switching
   to per msk page frag use, and checking mptcp seq number for coalescing

Paolo Abeni (3):
  mptcp: use sk_page_frag() in sendmsg
  mptcp: sendmsg() do spool all the provided data
  mptcp: allow collapsing consecutive sendpages on the same substream

 net/mptcp/protocol.c | 181 ++++++++++++++++++++++++++++---------------
 1 file changed, 119 insertions(+), 62 deletions(-)

-- =

2.20.1


--===============0891196408084643454==--
