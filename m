Content-Type: multipart/mixed; boundary="===============0350347681730650298=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] mptcp: Minor changes to path manager interface
Date: Wed, 11 Sep 2019 22:57:41 +0200
Message-ID: <75f64b5dad7a90eeec8a09072507fae53e178f19.camel@redhat.com>
In-Reply-To: 20190907013002.2759-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1827

--===============0350347681730650298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-06 at 18:30 -0700, Peter Krystad wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3c678d52ae1e..06a1cea45efe 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1135,7 +1135,6 @@ void mptcp_proto_init(void)
>  =

>  	token_init();
>  	subflow_init();
> -	pm_init();

I guess we should also remove pm_init() definition, but that can go
with a later clean-up patch. I think this patch can be merged as-is.

Paolo


--===============0350347681730650298==--
