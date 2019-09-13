Content-Type: multipart/mixed; boundary="===============2858071793706047958=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH net-next] mptcp: really try to read as much bytes
 as requested
Date: Fri, 13 Sep 2019 10:50:09 +0200
Message-ID: <a73ebd1fafe34fdb3b92bfd4a948c4d18ea75cef.camel@redhat.com>
In-Reply-To: 61cfdb1b116824c24e8dd6d42f375ee3358008e5.1558370826.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1836

--===============2858071793706047958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-13 at 10:47 +0200, Paolo Abeni wrote:
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 06312efc0b90..335a13bfc43e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -506,11 +506,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>  		}
>  =

>  		copied +=3D bytes_read;
> +		continue;
>  =

>  wait_for_data:
> -		if (copied)
> -			break;
> -
>  		if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
>  			pr_err("Urgent data present, cannot proceed");
>  			break;

oops, this patch is pure noise, I'm sorry. =


I unitentionally flushed an old and broken version of 2/2 in "mptcp:
partial recvmsg() refactor" togethar with the current series. =


Please drop/ignore this one.

Paolo


--===============2858071793706047958==--
