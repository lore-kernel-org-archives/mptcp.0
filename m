Content-Type: multipart/mixed; boundary="===============4144099912649965483=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: mptcp: refactor shutdown and
 close
Date: Mon, 12 Oct 2020 15:03:14 +0200
Message-ID: <3bafa870-b473-347f-f4eb-05edb067c3e6@tessares.net>
In-Reply-To: 24df6b98e251b2d67c25f12eb3c6c974aafa0101.1602241020.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6289

--===============4144099912649965483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 09/10/2020 12:57, Davide Caratti wrote:
> the format specifier for 'write_seq' in __mptcp_check_send_data_fin()
> should be the same as the one used for 'snd_nxt', to prevent humans
> from becoming suddenly sad while inspecting the output of pr_debug().
> Change both 'snd_nxt' and 'write_seq' to be %llu.

Thank you for the patch!

- d98cacd423dc: "squashed" in "mptcp: refactor shutdown and close"
- b61eb228f4a3: "Signed-off-by" + "Co-developed-by"

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4144099912649965483==--
