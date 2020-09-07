Content-Type: multipart/mixed; boundary="===============1429369741801289166=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: add ADD_ADDR related mibs"
Date: Mon, 07 Sep 2020 11:52:09 +0200
Message-ID: <b880b03e-61e2-1c57-1c28-5d3b14b27e69@tessares.net>
In-Reply-To: 0a4053db6ce391392514c394f83386ed75efa050.1599470677.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5746

--===============1429369741801289166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 07/09/2020 11:37, Paolo Abeni wrote:
> mptcp_incoming_options() can be called with either BH enabled or
> disabled, so we need to use the safer MIB accounting helper
> version.
> =

> This fixes isssue#86

Thank you for the fix. I had the same ready this morning but some =

meetings didn't allow me to send the patch :)

- 1cca88bf8dd6: "squashed" in "mptcp: add ADD_ADDR related mibs"
- f0fcae160636: "Signed-off-by" + "Co-developed-by"
- 522700f41751..fa888ff43702: result

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1429369741801289166==--
