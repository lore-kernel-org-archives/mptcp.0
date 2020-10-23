Content-Type: multipart/mixed; boundary="===============3901587870140358480=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: keep unaccepted MPC subflow into
 join list
Date: Fri, 23 Oct 2020 20:00:58 +0200
Message-ID: <aac5a685-26a3-9eff-f40c-752f03bb8fd6@tessares.net>
In-Reply-To: 2c16fd8e71c04ce6f38e2b3eafafb3996f95aa77.1603200777.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6425

--===============3901587870140358480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Geliang,

On 20/10/2020 16:54, Paolo Abeni wrote:
> This will simplify all operation dealing with subflows
> before accept time (e.g. data fin processing, add_addr).
> =

> The join list is already flushed by mptcp_stream_accept()
> before returning the newly created msk to the user space.
> =

> This also fixes an potential bug present into the old code:
> conn_list was manipulated without helding the msk lock
> in mptcp_stream_accept().

Thank you for the patch, review and validation!

Just applied:

- cdf7f6c99e86: mptcp: keep unaccepted MPC subflow into join list
- Results: a1e156132206..d13ebf3a735c

With Mat and Geliang's tags.

Tests + export is in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3901587870140358480==--
