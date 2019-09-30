Content-Type: multipart/mixed; boundary="===============1191722348609415642=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Remove all traces of checksum support
Date: Mon, 30 Sep 2019 16:08:33 +0200
Message-ID: <a60dc7d1c6a6b010292340a47a437b9cb0e55007.camel@redhat.com>
In-Reply-To: 20190925234411.2617-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1962

--===============1191722348609415642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-09-25 at 16:44 -0700, Peter Krystad wrote:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f1f5ab3990ab..400fbb0060f3 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -173,7 +173,7 @@ struct subflow_request_sock {
>  	struct	tcp_request_sock sk;
>  	u8	mp_capable : 1,
>  		mp_join : 1,
> -		checksum : 1,
> +		unused : 1,
>  		backup : 1,
>  		version : 4;
>  	u8	local_id;

Sorry I did not notice this beforehand. It looks a little strange to me
creating a new struct with some 'unused' field. But I think is not
blocking: we can merge the patch as-is and ev. drop the field later -
if there is agreement on that.

Cheers,

Paolo

--===============1191722348609415642==--
