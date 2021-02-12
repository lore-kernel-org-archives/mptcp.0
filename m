Content-Type: multipart/mixed; boundary="===============3672316221857137654=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: fail if
 not enough SYN/3rd ACK"
Date: Fri, 12 Feb 2021 20:53:58 +0100
Message-ID: <9e49303c-6086-6b2d-82c3-286420b26a22@tessares.net>
In-Reply-To: 20210212083528.84431-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7777

--===============3672316221857137654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 12/02/2021 09:35, Matthieu Baerts wrote:
> We should check the opposite: 'now' lower than 'expected' and not the
> opposite ('expected' lower than 'now') to consider the test as failed.
> =

> I also modified the failed message to make it clearer but also because
> my TAP parser is rendering the '>' with '&gt;'... XML is still alive!

To avoid wrong errors reported by CI or anybody launching our selftests, =

certainly best to apply it ASAP :)

- 7edabb5edac1: "squashed" in "selftests: mptcp: fail if not enough =

SYN/3rd ACK"
- Results: 8ea9c48639fd..5efc57c1d1d5

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3672316221857137654==--
