Content-Type: multipart/mixed; boundary="===============3058688035405278121=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: drop unused subflow in
 mptcp_pm_subflow_established
Date: Wed, 17 Feb 2021 21:09:07 +0100
Message-ID: <e8f486f1-dc9f-5f35-4b25-b2314d2ed9e9@tessares.net>
In-Reply-To: 0c4e5341b9f9e8bbd38c3b882284f58babf786b8.1613183930.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7833

--===============3058688035405278121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 13/02/2021 03:48, Geliang Tang wrote:
> This patch drops the unused parameter subflow in
> mptcp_pm_subflow_established().

Thank you for the patch and the review!
Just added in our tree before your "RM list of addresses" series with =

Mat's RvB tag and a Fixes tag.

- b032057322f1: mptcp: drop unused subflow in mptcp_pm_subflow_established
- Results: afc69f9d3c92..b5843b11a4b1

Tests + export have been queued.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3058688035405278121==--
