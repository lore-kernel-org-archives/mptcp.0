Content-Type: multipart/mixed; boundary="===============3403280367648680399=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: refactor xmit path
Date: Tue, 07 May 2019 15:15:06 +0200
Message-ID: <cover.1557234490.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1120

--===============3403280367648680399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this series refactor the mptcp xmit path trying to make sendmsg behavior
more consistent, memory efficent and improve its performances.

To support MP_JOIN and multiple subflows, the idea is adding, with later
patches, an RB-tree structure containing references to the pending page
fragments, their length and the associated mptcp write_seq number (is subfl=
ow
rel_write_seq needed, too?). RB-tree node can be allocated using the same
page frag used in this series for skb data. Each RB-tree node will own a
reference to the page frag.

v1  -> v2:
 - rebased on top of current git
 - fix handling of some corner cases

RFC -> v1:
 - addressed Mat's feedback, dropping patch 3/4 and switching
   to per msk page frag use, and checking mptcp seq number for coalescing

Paolo Abeni (3):
  mptcp: use sk_page_frag() in sendmsg
  mptcp: sendmsg() do spool all the provided data
  mptcp: allow collapsing consecutive sendpages on the same substream

 net/mptcp/protocol.c | 190 ++++++++++++++++++++++++++++---------------
 1 file changed, 123 insertions(+), 67 deletions(-)

-- =

2.20.1


--===============3403280367648680399==--
