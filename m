Content-Type: multipart/mixed; boundary="===============6051371767114218546=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3] mptcp: track window announced to
 peer
Date: Tue, 27 Oct 2020 21:14:23 +0100
Message-ID: <2f497c34-351c-f703-e53e-b11ddddefc00@tessares.net>
In-Reply-To: 20201022212738.24258-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6450

--===============6051371767114218546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat, Paolo,

On 22/10/2020 23:27, Florian Westphal wrote:
> OoO handling attemtps to detect when packet is out-of-window by testing
> current ack sequence and remaining space vs. sequence number.
> =

> This doesn't work reliably.  Store the highest allowed sequence number
> that we've announced and use it to detect oow packets.
> =

> Do this when mptcp options get written to the packet (wire format).
> For this to work we need to move the write_options call until after stack
> selected a new tcp window.

Thank you for the patch and reviews!

- 99873062750d: mptcp: track window announced to peer
   - I added Mat's Reviewed-by and Paolo's Acked-by tags, please tell me =

if you prefer when I don't add those if they are not explicit. It is =

just to avoid multiple messages on the netdev ML.
   - (I fixed a small typo with 'attempts' in the commit message and =

reported by codespell)
- Results: 9bceebfe0a58..c041aa4e115c

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6051371767114218546==--
