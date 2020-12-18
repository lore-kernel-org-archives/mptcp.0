Content-Type: multipart/mixed; boundary="===============6804103231760350509=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 2/8] mptcp: add port number
 check for MP_JOIN
Date: Thu, 17 Dec 2020 16:17:33 -0800
Message-ID: <ffacb35c-b66c-699f-6d9-b2ab4a213574@linux.intel.com>
In-Reply-To: 6fe8a4f118716ea43fedad741cc129292027fdbe.1607823272.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7211

--===============6804103231760350509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Dec 2020, Geliang Tang wrote:

> This patch added two new helpers, subflow_use_different_sport and
> subflow_use_different_dport, to check whether the subflow's source or
> destination port number is different from the msk's port number. When
> we received the MP_JOIN's SYN/SYNACK/ACK, we do these port number
> checks and print out the different port numbers.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/subflow.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>

Please squash this with patch 3.

Thanks,
--
Mat Martineau
Intel
--===============6804103231760350509==--
