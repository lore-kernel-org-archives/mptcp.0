Content-Type: multipart/mixed; boundary="===============2052172836660601393=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/6] mptcp: update mptcp ack sequence from work
 queue
Date: Mon, 17 Feb 2020 16:00:55 +0100
Message-ID: <20200217150101.13603-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3669

--===============2052172836660601393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi.

This is v2 of the attempt to allow mptcp to update its ack-sequence
number even if userspace doesn't call recv() for some time.

I tried to address all comments from previous feedback.

tcp_read_sock() is not used anymore, skbs are moved off the subflow
receive queue and re-linked to the mptcp receive queue.

The inner loop in mptcp_recvmsg is gone. skbs are only taken
from the mptcp receive queue.  In case that mptcp receive queue is
empty, it will pull skbs off the subflow receive queue.

Thus, the previous patch to make tcp_read_sock actors eat skbs
isn't included in this series anymore.

Patch 4 is new: after removing the inner loop from recvmsg
we can also move the actor callback to subflow.c.

Patch 5 is also new, but not strictly related to this series.
Patch 6 isn't strictly required, but I think its a good idea anyway
to do this so that we don't need to rely on bulk traffic to generate
acks/enough window updates.

Thanks,
Florian


--===============2052172836660601393==--
