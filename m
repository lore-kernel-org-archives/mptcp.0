Content-Type: multipart/mixed; boundary="===============5551775118733886227=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] bpf: move bpf_mptcp_sock_ fn out of
 CONFIG_INET
Date: Sat, 14 Nov 2020 09:24:27 +0100
Message-ID: <40520a9c-539d-7299-7086-cfb8efd0d0e2@tessares.net>
In-Reply-To: 20201114081936.2617526-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6729

--===============5551775118733886227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 14/11/2020 09:19, Matthieu Baerts wrote:
> If CONFIG_INET is not enabled, our bpf_mptcp_sock_*() functions were not
> declared as reported by the 0-day bot.
> =

> We can simply move these bpf_mptcp_sock_*() functions out of
> =

>    #ifdef CONFIG_INET
> =

> Because these functions are surrounded with:
> =

>    #ifdef CONFIG_MPTCP
> =

> which depends on CONFIG_INET.

I guess I don't need an external review for this.

Applied in our git tree:

- 1800469e0a75: bpf: move bpf_mptcp_sock_ fn out of CONFIG_INET
- Results: 39f581445bc2..39fccf50eeb0

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5551775118733886227==--
