Content-Type: multipart/mixed; boundary="===============9055426834492459104=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: use adding up
 size to get ADD_ADDR length"
Date: Thu, 03 Dec 2020 18:25:58 +0100
Message-ID: <3edf68e7-24e5-8b4c-ba44-386cdd17eb35@tessares.net>
In-Reply-To: e021e1924a8c0e6bd51c7a0253bba471fe3ee0a1.1606898909.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7028

--===============9055426834492459104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 02/12/2020 09:51, Geliang Tang wrote:
> Drop the duplicate macro TCPOLEN_MPTCP_ADD_ADDR_HMAC, use MPTCPOPT_THMAC_=
LEN
> instead.

Thank you for the patch and the nice instructions!

- 189c4a2779be: "squashed" in mptcp: use adding up size to get ADD_ADDR =

length
- 37dd54c02583: conflict in t/mptcp-add-the-outgoing-ADD_ADDR-port-support
- Results: 9b24e551c22a..fd535b120ea9

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============9055426834492459104==--
