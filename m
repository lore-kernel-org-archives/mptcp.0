Content-Type: multipart/mixed; boundary="===============5441921825259275120=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 11/12] mptcp: add the mib for
 ADD_ADDR with port
Date: Thu, 05 Nov 2020 15:04:43 +0100
Message-ID: <b3a5f89c-8ec8-981c-6921-98e9537f163b@tessares.net>
In-Reply-To: 2447fed3519d7acdbbc1376529bdb36505eb6301.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6567

--===============5441921825259275120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 05/11/2020 09:01, Geliang Tang wrote:
> This patch added the mib for ADD_ADDR with port, named MPTCP_MIB_PORTADD,
> for receiving of the ADD_ADDR suboption with a port number.

This MIB is useful!

I think what could also be useful is a MIB counter we would increase =

when we receive an MP_JOIN to a different port than the original one. =

What do you think?

It can be useful for those using this feature and also for our =

selftests: to validate we correctly receive the SYN+MPJ on a different =

port than the original one as expected, no?

I just see a risk with the new selftests that we don't see the new =

subflow is in fact established to the wrong port, not the one we =

expected. Or do we have a check for that?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5441921825259275120==--
