Content-Type: multipart/mixed; boundary="===============1794480437331157029=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Mon, 14 Oct 2019 16:40:06 -0700
Message-ID: <alpine.OSX.2.21.1910141633260.18802@ntadesse-mobl.amr.corp.intel.com>
In-Reply-To: 56236D15-C0F3-41E2-B91E-B9D7038300FC@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2130

--===============1794480437331157029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Oct 2019, Christoph Paasch wrote:

>
>
>> On Oct 13, 2019, at 9:48 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
>>
>> Hi Mat,
>>
>> While working on the recvmsg() refactor I noticed some bits/changes may
>> overlap with and/or conflict with data_fin support, please have a look
>> at patches I just posted!
>>
>> Some comments on the code below...
>>
>> On Fri, 2019-10-11 at 21:32 -0700, Mat Martineau wrote:
>>> @@ -404,6 +406,21 @@ static bool mptcp_established_options_dss(struct s=
ock *sk, struct sk_buff *skb,
>>> 			dss_size =3D map_size;
>>> 			if (mpext)
>>> 				opts->ext_copy =3D *mpext;
>>> +
>>> +			/* This creates self test failures, still tracking
>>> +			 * down the root cause */
>>> +			if (subflow->send_data_fin && !opts->ext_copy.use_map &&
>>> +			    subflow->conn) {
>>> +				struct mptcp_sock *msk;
>>> +
>>> +				/* Required for DATA_FIN without data payload */
>>> +				msk =3D mptcp_sk(subflow->conn);
>>> +				opts->ext_copy.use_map =3D 1;
>>> +				opts->ext_copy.dsn64 =3D 1;
>>> +				opts->ext_copy.data_seq =3D msk->write_seq;
>>> +				opts->ext_copy.subflow_seq =3D 0;
>>> +				opts->ext_copy.data_len =3D 1;
>>> +			}
>>
>> If I read the code correctly, this may end-up sending the data_fin too
>> early. I [mis]understand that data_fin should be added if and only if
>> no more data will follow, but I think there could be more data pending
>> in the tx queue, so we will end-up with an MPTCP out-of-order on the rx
>> side (later skbs can have a lower MPTCP seq number)
>
> In principle it is ok to send the DATA_FIN even when there is still data =
in the tx-queue. The segment with the DATA_FIN will simply end up in the ou=
t-of-order queue on the receiver and wait for all the other data to be tran=
smitted.
>
> That being said, I think it still makes sense to wait until all the data =
has been sent, just like TCP also doesn't send an out-of-order FIN when the=
 connection is being closed.
>
>
> Cheers,
> Christoph
>
>>
>>> @@ -1413,6 +1502,7 @@ static int mptcp_shutdown(struct socket *sock, in=
t how)
>>>
>>> 		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
>>> 		pr_debug("conn_list->subflow=3D%p", subflow);
>>> +		subflow->send_data_fin =3D 1;
>>
>> I think here you could also record the current msk->write_seq, then in
>> mptcp_established_options_dss you can set data_fin on the skb carring
>> the specified seq, or any pure ack pkt send after the specified MPTCP
>> seq number.
>>
>> WDYT ?

Thanks for the comments - I will make sure DATA_FIN does not get sent too =

soon.

--
Mat Martineau
Intel
--===============1794480437331157029==--
