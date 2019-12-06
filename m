Content-Type: multipart/mixed; boundary="===============8701901172448572657=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/3] mptcp: support for rfc6824 MP CAPABLE
 hanshake
Date: Fri, 06 Dec 2019 14:07:31 +0100
Message-ID: <a7d7fb0d-8966-978f-82a7-4a4d90ca6b47@tessares.net>
In-Reply-To: 20191205193612.1781-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2817

--===============8701901172448572657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Paolo, Peter,

On 05/12/2019 20:36, Christoph Paasch wrote:
> Third iteration of the v1 MP_CAPABLE handshake, incorporating the
> feedback we got from Peter & Matt.
> =

> The patches apply just before "mptcp: add basic kselftest for mptcp".

Thank you for the patches, reviews and support!

As discussed yesterday, I applied the 3 new patches just *after* "mptcp: =

add basic kselftest for mptcp".

- eb5a8192c95b: conflict in t/mptcp-Add-path-manager-interface
- 275bbf5f90ad: conflict in t/mptcp-Add-ADD_ADDR-handling
- 0bc741b10045: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 6b6db9f31531: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- bf2741a34a46: conflict in =

t/mptcp-update-per-unacked-sequence-on-pkt-reception
- 66f4bf4e2ebd: conflict in =

t/recv-make-DATA_READY-reflect-ssk-in-sequence-state
- b887804d061e..219f243dcb66: result
- 84384f90c00d: small fix suggested by Paolo, saw when doing the rebase, =

"squashed" in "mptcp: parse and emit MP_CAPABLE option according to v1 =

spec."
- 219f243dcb66..f254fde6968b: 2nd result (empty, normal)
- ba5637b5c223: fix compilation error without CONFIG_MPTCP, "squashed" =

in "mptcp: parse and emit MP_CAPABLE option according to v1 spec."
- f254fde6968b..048a73890db7: 3rd result
- 09dc9b79c639: avoid code duplication when validating MPC. After the =

small fix from above, we had a value potentially set two times.
- 048a73890db7..343c06fe2029: result

I just checked the compilations with and without MPTCP, selftests at the =

end of part 2 and at the end of the series. I didn't check that each =

commit compiles. Will do that when I have applied everything.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8701901172448572657==--
