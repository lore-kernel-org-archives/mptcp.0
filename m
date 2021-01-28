Content-Type: multipart/mixed; boundary="===============4378459560310433678=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] net: mptcp: fix length of MP_PRIO
 sub-option
Date: Thu, 28 Jan 2021 15:12:45 +0100
Message-ID: <927b25c1-18d1-ea26-ffcd-422d09592114@tessares.net>
In-Reply-To: f675bf58efc120401bd776a63c3472455c3898d9.1611839010.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7502

--===============4378459560310433678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 28/01/2021 14:07, Davide Caratti wrote:
> With version 0 of the protocol it was legal to encode the 'Subflow Id' in
> the MP_PRIO suboption, to specify which subflow would change its 'Backup'
> flag. This has been removed from v1 specification: thus, according to RFC
> 8684 =C2=A73.3.8, the resulting 'Length' for MP_PRIO changed from 4 to 3 =
byte.
> =

> Current Linux generates / parses MP_PRIO according to the old spec, using
> 'Length' equal to 4, and hardcoding 1 as 'Subflow Id'; RFC compliance can
> improve if we change 'Length' in other to become 3, leaving a 'Nop' after
> the MP_PRIO suboption. In this way the kernel will emit and accept *only*
> MP_PRIO suboptions that are compliant to version 1 of the MPTCP protocol.

Thank you for the patch!

(Note: for the subject, I think you can remove "net: ". MPTCP patches =

are usually sent without it)

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 775f0576592e..6e088c583992 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -699,10 +699,11 @@ static bool mptcp_established_options_mp_prio(struc=
t sock *sk,
>   	if (!subflow->send_mp_prio)
>   		return false;
>   =

> -	if (remaining < TCPOLEN_MPTCP_PRIO)
> +	/* account for the trailing 'nop' option */
> +	if (remaining < TCPOLEN_MPTCP_PRIO + 1)

Mmh, that's tricky to choose between v1 and v2 :)
I agree with Geliang that it is better to set the proper value for =

TCPOLEN_MPTCP_PRIO but not nice to have the +1 here I think.

What about a mix of v1 and v2?

- TCPOLEN_MPTCP_PRIO is set to 3
- adding a new one, e.g. TCPOLEN_MPTCP_PRIO_ALIGN, set to 4 and use here =

to avoid the +1 but still you can keep you new comment.

WDYT? :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4378459560310433678==--
