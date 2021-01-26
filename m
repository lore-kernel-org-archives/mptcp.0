Content-Type: multipart/mixed; boundary="===============0730379028652221832=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 5/5] mptcp: add netlink event support
Date: Tue, 26 Jan 2021 08:51:12 -0800
Message-ID: <12f9b4df-181a-112e-8563-e58a0768842@linux.intel.com>
In-Reply-To: d3bf3890-d052-85d7-08df-eea758c05f86@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7490

--===============0730379028652221832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Jan 2021, Matthieu Baerts wrote:

> Hi Florian,
>
> On 20/01/2021 18:15, Matthieu Baerts wrote:
>> On 20/01/2021 16:43, Florian Westphal wrote:
>>
>>  > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>>  > index 3674a451a18c..4983ced8e1f8 100644
>>  > --- a/include/uapi/linux/mptcp.h
>>  > +++ b/include/uapi/linux/mptcp.h
>>  > @@ -36,6 +36,7 @@ enum {
>>  >=C2=A0=C2=A0 /* netlink interface */
>>  >=C2=A0=C2=A0 #define MPTCP_PM_NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "mptcp_pm"
>>  >=C2=A0=C2=A0 #define MPTCP_PM_CMD_GRP_NAME=C2=A0=C2=A0=C2=A0 "mptcp_pm=
_cmds"
>>  > +#define MPTCP_PM_EV_GRP_NAME=C2=A0=C2=A0=C2=A0 "mptcp_events"
>> =

>> We will check if it is OK for Ossama :)
>
> Just to be sure it is clear for everyone, it was decided yesterday at the =

> weekly meeting to switch to "mptcp_pm_events".
>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index e2f40985b450..c2939362f47a 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>> =

>> (...)
>> =

>>> +static int mptcp_event_put_token_and_ssk(struct sk_buff *skb,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct mptcp_sock=
 *msk,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct sock *ssk)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 const struct sock *sk =3D (const struct sock *)msk;
>>> +=C2=A0=C2=A0=C2=A0 const struct mptcp_subflow_context *sf;
>>> +=C2=A0=C2=A0=C2=A0 u8 sk_err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EMSGSIZE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (mptcp_event_add_subflow(skb, ssk))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EMSGSIZE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sf =3D mptcp_subflow_ctx(ssk);
>>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!sf))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (nla_put_u8(skb, MPTCP_ATTR_BACKUP, sf->backup))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EMSGSIZE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ssk->sk_bound_dev_if &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nla_put_s32(skb, MPTCP_ATTR=
_IF_IDX, ssk->sk_bound_dev_if))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EMSGSIZE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sk_err =3D ssk->sk_err;
>> =

>> Could we have an error set on the msk? (sk->sk_err)
>
> And here, as discussed yesterday, we would keep "ssk->sk_err" and not use=
 the =

> one from the msk.
>
> I guess Mat and Ossama prefer to quickly validate it before applying thes=
e =

> patches, I can wait before applying them. Or maybe I misunderstood and I =
can =

> apply it sooner.
> (And if we only need to change the group name, I can fix that when applyi=
ng =

> it without having to submit a new version ;-) )
>

Hi Matthieu -

Go ahead and apply the series to the export branch with the group name =

fix, if other fixes are needed after testing we can squash those.

Thanks,

--
Mat Martineau
Intel

--===============0730379028652221832==--
