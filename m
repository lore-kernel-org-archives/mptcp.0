Content-Type: multipart/mixed; boundary="===============6775510052977268664=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/6] mptcp: avoid workqueue usage for data
Date: Mon, 30 Nov 2020 18:34:04 -0800
Message-ID: <20201130183404.01abe8dd@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: cover.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6998

--===============6775510052977268664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020 11:10:21 +0100 Paolo Abeni wrote:
> The current locking schema used to protect the MPTCP data-path
> requires the usage of the MPTCP workqueue to process the incoming
> data, depending on trylock result.
> =

> The above poses scalability limits and introduces random delays
> in MPTCP-level acks.
> =

> With this series we use a single spinlock to protect the MPTCP
> data-path, removing the need for workqueue and delayed ack usage.
> =

> This additionally reduces the number of atomic operations required
> per packet and cleans-up considerably the poll/wake-up code.

Applied, thanks!
--===============6775510052977268664==--
