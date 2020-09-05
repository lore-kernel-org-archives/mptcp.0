Content-Type: multipart/mixed; boundary="===============6780605609200150353=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC mptcp-next 0/3] mptcp: rework poll+nospace handling
Date: Sat, 05 Sep 2020 12:33:21 +0200
Message-ID: <20200905103324.27066-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5727

--===============6780605609200150353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A while back I had a discussion with Paolo on how mptcp handles the
'is mptcp socket writeable' handling in the sendmsg path, rather than
the poll one.

There are only two cases:
1. Blocking IO, where userspace calls send/read.
   In this scenario, maintaining the MPTCP_SEND_SPACE bit in sendmsg
   path is useless extra work -- userspace will block at send time if
   no more wmem is available.

2. Nonblocking IO.
   If userspace calls sendmsg without checking poll first, it has
   to cope with -EAGAIN.
   If userspace does call poll first, then mptcp can do the 'is
   mptcp socket writeable' check in mptcp_poll.

Consequently, patch #2 removes ssk_check_wmem().  A similar test
is added to mptcp_poll().

Furthermore, the MPTCP_SEND_SPACE bit has its meaning inverted and
gets renamed to MPTCP_NOSPACE.  Its only function is to let the
mptcp_data_acked() path know if the mptcp worker needs to be scheduled
or not.

IOW, when sendmsg path is going to sleep, or when poll path finds
socket isn't writeable, this bit makes sure that the next data ack
will wake userspace.

For the unlikely case that the mptcp socket is writeable but subflow
sockets are not, this will still enable tcp-level callbacks via the
SOCK_NOSPACE machinery.

Sending as RFC for now as I'm not sure others consider this approach
better or easier to follow then what we currently have.

First patch might be useful in its own right even if #2 is rejected.


--===============6780605609200150353==--
