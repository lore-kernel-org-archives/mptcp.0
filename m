Content-Type: multipart/mixed; boundary="===============5888440067935841908=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 02/10] mptcp: unify ADD_ADDR
 and ADD_ADDR6 suboptions writing
Date: Tue, 03 Nov 2020 18:23:32 +0100
Message-ID: <7c5ecd37-5bcb-d232-3450-716542390544@tessares.net>
In-Reply-To: 5d9becee199f0ffbec60d34451b4779c4c9773c9.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6521

--===============5888440067935841908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 31/10/2020 16:24, Geliang Tang wrote:
> The length of ADD_ADDR6 is 12 octets longer than ADD_ADDR. That's the
> only difference between them.
> =

> This patch dropped the duplicate code between ADD_ADDR and ADD_ADDR6
> suboptions writing, and unify them into one.

It is nice to avoid similar code but here, I think you are changing the =

behaviour if CONFIG_MPTCP_IPV6 is disabled. If I am not mistaken, we are =

going to reserve space but not write anything in it except the hmac.

For the moment, it is fine because we will not call mptcp_write_options =

with OPTION_MPTCP_ADD_ADDR6 but I don't know if we can safely take that =

into consideration for a "public" function called from TCP.

Maybe "safer" by using a helper taking different arguments for v4 and =

v6? In this case we could have something like:


	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
		mptcp_write_add_addr_option(ptr, opts,
					   TCPOLEN_MPTCP_ADD_ADDR_BASE);
	}

#if IS_ENABLED(CONFIG_MPTCP_IPV6)
	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
		mptcp_write_add_addr_option(ptr, opts,
					  TCPOLEN_MPTCP_ADD_ADDR6_BASE);
	}
#endif

Or we add a comment mentioning we should not have OPTION_MPTCP_ADD_ADDR6 =

if IPV6 is disabled?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5888440067935841908==--
