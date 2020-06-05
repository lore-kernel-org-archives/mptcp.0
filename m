Content-Type: multipart/mixed; boundary="===============2758239778746451183=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC net-next 2/2] mptcp: fix races between
 shutdown and recvmsg.
Date: Fri, 05 Jun 2020 16:31:39 +0200
Message-ID: <640f663a-6431-6df5-877f-2f684abc1bd5@tessares.net>
In-Reply-To: 6b71f5e37a9e2b3eb2fab51354ef2b168fdc9b09.1589819601.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4596

--===============2758239778746451183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Davide, Mat,

On 18/05/2020 18:37, Davide Caratti wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> =

> The msk sk_shutdown flag is set by a workqueue, possibly
> introducing some delay in user-space notification. If the last
> subflow carries some data with the fin packet, the user space
> can wake-up before RCV_SHUTDOWN is set. If it executes unblocking
> recvmsg(), it may return with an error instead of eof.
> =

> Address the issue explicitly checking for eof in recvmsg(), when
> no data is found.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch and the review!

Just added to the TopGit tree. The export branch has not been updated yet.

As discussed on IRC, I added a "Fixes" tag. (and I remove the dot at the =

end of the commit title :) )

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2758239778746451183==--
