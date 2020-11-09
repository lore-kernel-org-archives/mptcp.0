Content-Type: multipart/mixed; boundary="===============3339057794908008432=="
MIME-Version: 1.0
From: Colin Ian King <colin.king at canonical.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH][next] mptcp: fix a dereference of pointer before
 msk is null checked.
Date: Mon, 09 Nov 2020 14:38:47 +0000
Message-ID: <b5c267c1-f116-419c-92c9-88a56f9a3b51@canonical.com>
In-Reply-To: CA+WQbwsAn_4160ZR0P50McuhadLG_M_uC9mAvf_85DJLDeoSVQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6601

--===============3339057794908008432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/11/2020 14:36, Geliang Tang wrote:
> Hi Colin,
> =

> Thanks for your patch. But this bug is reported by Dan Carpenter to MPTCP
> ML earlier, and I have already sent out a fix in MPTCP ML for review. So
> your fix is duplicated. I'm sorry.

Oh I missed Dan's fix. No problem, glad it is fixed. :-)

> =

> -Geliang
> =

> Colin King <colin.king(a)canonical.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=88=
9=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:52=E5=86=99=E9=81=93=EF=BC=
=9A
> =

>>
>> From: Colin Ian King <colin.king(a)canonical.com>
>>
>> Currently the assignment of pointer net from the sock_net(sk) call
>> is potentially dereferencing a null pointer sk. sk points to the
>> same location as pointer msk and msk is being null checked after
>> the sock_net call.  Fix this by calling sock_net after the null
>> check on pointer msk.
>>
>> Addresses-Coverity: ("Dereference before null check")
>> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
>> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
>> ---
>>  net/mptcp/pm_netlink.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index ed60538df7b2..e76879ea5a30 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -206,13 +206,15 @@ static void mptcp_pm_add_timer(struct timer_list *=
timer)
>>         struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, ad=
d_timer);
>>         struct mptcp_sock *msk =3D entry->sock;
>>         struct sock *sk =3D (struct sock *)msk;
>> -       struct net *net =3D sock_net(sk);
>> +       struct net *net;
>>
>>         pr_debug("msk=3D%p", msk);
>>
>>         if (!msk)
>>                 return;
>>
>> +       net =3D sock_net(sk);
>> +
>>         if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
>>                 return;
>>
>> --
>> 2.28.0
>>

--===============3339057794908008432==--
