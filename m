Content-Type: multipart/mixed; boundary="===============2275105626108554691=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: use MPTCPOPT_HMAC_LEN
 macro
Date: Fri, 04 Dec 2020 18:09:21 +0100
Message-ID: <050d2b9d-41fa-04a3-4209-1b282334b7c3@tessares.net>
In-Reply-To: 1ab161c24f9027ce76b3483f025be8bbfa0c7667.1606899179.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7054

--===============2275105626108554691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 02/12/2020 09:54, Geliang Tang wrote:
> Use the macro MPTCPOPT_HMAC_LEN instead of a constant in struct
> mptcp_options_received.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the patch and the review!

This patch has been applied after other patches from Geliang.

- 0ebaa63b1d30: mptcp: use MPTCPOPT_HMAC_LEN macro
   - With Mat's tag
- Results: 95b2727396d3..8e81e32d0db6

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2275105626108554691==--
