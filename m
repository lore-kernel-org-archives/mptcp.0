Content-Type: multipart/mixed; boundary="===============7052211607849306768=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/8] mptcp: update mptcp ack sequence outside
 of recv path
Date: Tue, 25 Feb 2020 13:05:18 +0100
Message-ID: <20200225120526.2866-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3770

--===============7052211607849306768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

this is a rework of the earlier patch set that moved mptcp-level ack
processing to work queue.

This is a slight variation of the same patchset, only that this time
the update is done from the ssk data_ready notification directly, if
possible.

I've split this into several steps to ease review, so patch #3 will
move the ack processing to the work queue, then patch 6 will add the
first 'avoid schedule_work()' scheme by attempting to handle the
ack update/skb move to mptcp receive queue directly in the data_ready
callback.

Last patch then moves the schedule_work to the mptcp socket release
callback, where we can avoid the schedule in case last recv emptied
all subflows (i.e., managed to move all skbs to the mptcp receive
queue).

The work queue is still scheduled from time to time, but way less
frequent than before.

When more work queue users get added (e.g. for retransmit support),
the amount of times where the work queue is run without any work to be
is almost at 0 for the entire mptcp selftest script invocation.

I've dropped 'mptcp: protocol: re-check dsn before reading from
subflow', its not related to this work and not needed until multiple
subflows get added and the
'mptcp: send acks when moving skbs to mptcp receive queue' change, which
can be done as followup.



--===============7052211607849306768==--
