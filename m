Content-Type: multipart/mixed; boundary="===============5944925950346976945=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests: mptcp: avoid calling
 pm_nl_ctl with bad IDs
Date: Fri, 12 Mar 2021 23:27:32 +0800
Message-ID: <CA+WQbwuTn0pSGr7+eaD9zNDQYX+MN3ZoguYCW5RamkyfC1MneA@mail.gmail.com>
In-Reply-To: 20210312151358.3426301-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8122

--===============5944925950346976945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:14=E5=86=99=E9=81=
=93=EF=BC=9A

>
> IDs are supposed to be between 0 and 255.
>
> In pm_nl_ctl, for both the 'add' and 'get' instruction, the ID is casted
> in a u_int8_t. So if we give 256, we will delete ID 0. Obviously, the
> goal is not to delete this ID by giving 256.
>
> We could modify pm_nl_ctl and stop if the ID is negative or higher than
> 255 but probably better not to increase the number of lines for such
> things in this tool which is only used in selftests. Instead, we use it
> within the limits.
>
> This modification also means that we will no longer add a new ID for the
> 2nd entry. That's why we removed an expected entry from the dump and
> introduced with
> commit dc8eb10e95a8 ("selftests: mptcp: add testcases for setting the add=
ress ID").
>
> So now we delete ID 9 like before and we add entries for IDs 10 to 255
> that are deleted just after.
>
> Note that this could be seen as a fix but it was not really an issue so
> far: we were simply playing with ID 0/1 once again. With the following
> commit ("selftests: mptcp: add addr argument for del_addr"), it will be
> different because ID 0 is going to required an address. We don't want
> errors when trying to delete ID 0 without the address argument.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Thanks for your patch.

Acked-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

> ---
>  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/test=
ing/selftests/net/mptcp/pm_netlink.sh
> index a617e293734c..3c741abe034e 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -100,12 +100,12 @@ done
>  check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9=
" "hard addr limit"
>  check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
>
> -for i in `seq 9 256`; do
> +ip netns exec $ns1 ./pm_nl_ctl del 9
> +for i in `seq 10 255`; do
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
>         ip netns exec $ns1 ./pm_nl_ctl del $i
> -       ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
>  done
>  check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
> -id 2 flags  10.0.0.9
>  id 3 flags signal,backup 10.0.1.3
>  id 4 flags signal 10.0.1.4
>  id 5 flags signal 10.0.1.5
> --
> 2.30.2
>
--===============5944925950346976945==--
