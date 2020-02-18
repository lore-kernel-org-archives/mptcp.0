Content-Type: multipart/mixed; boundary="===============5553282680752590773=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/6] mptcp: update mptcp ack sequence from work
 queue
Date: Tue, 18 Feb 2020 13:21:04 +0100
Message-ID: <20200218122110.23817-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3692

--===============5553282680752590773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is v3 of the attempt to allow mptcp to update its ack-sequence
number even if userspace doesn't call recv() for some time.
This includes a change to patch 2/6 to address a theoretical race when
two subflows deliver same data: previous version may have discarded the
additional data correctly, but would leave EPOLLIN indication enabled,
even though all data has to be tossed as duplicate.

Rest of patches is unchanged.

Thanks,
Florian


--===============5553282680752590773==--
