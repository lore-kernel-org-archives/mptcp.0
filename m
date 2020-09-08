Content-Type: multipart/mixed; boundary="===============3625168578251952464=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Tue, 08 Sep 2020 13:33:35 -0700
Message-ID: <alpine.OSX.2.23.453.2009081003240.13022@fengzha2-mobl.amr.corp.intel.com>
In-Reply-To: 421e39795d3e6954c55b2e40b84e59ce9164dfe8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5762

--===============3625168578251952464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Sep 2020, Paolo Abeni wrote:

> On Thu, 2020-09-03 at 17:35 -0700, Mat Martineau wrote:
>> When receiving a DATA_FIN MPTCP option on a TCP FIN packet, the DATA_FIN
>> information would be stored but the MPTCP worker did not get
>> scheduled. In turn, the MPTCP socket state would remain in
>> TCP_ESTABLISHED and no blocked operations would be awakened.
>>
>> TCP FIN packets are seen by the MPTCP socket when moving skbs out of the
>> subflow receive queues, so schedule the MPTCP worker when a skb with
>> DATA_FIN but no data payload is moved from a subflow queue. Other cases
>> (DATA_FIN on a bare TCP ACK or on a packet with data payload) are
>> already handled.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>
>> This patch is targeted at the -net tree, but also applies to net-next
>> without conflict. If it looks ok, we can carry it in the export branch
>> until it gets merged to both -net and net-next.
>>
>> net/mptcp/subflow.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index e8cac2655c82..3297233dece7 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -731,7 +731,7 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
>>
>>  	if (mpext->data_fin =3D=3D 1) {
>>  		if (data_len =3D=3D 1) {
>> -			mptcp_update_rcv_data_fin(msk, mpext->data_seq);
>> +			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq);
>>  			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
>>  			if (subflow->map_valid) {
>>  				/* A DATA_FIN might arrive in a DSS
>> @@ -742,6 +742,9 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
>>  				skb_ext_del(skb, SKB_EXT_MPTCP);
>>  				return MAPPING_OK;
>>  			} else {
>> +				if (updated && schedule_work(&msk->work))
>> +					sock_hold((struct sock *)msk);
>> +
>
> We already have 'schedule_work' call to handle incoming data fin
> in mptcp_incoming_options(), can we instead extend the checks there to
> cover also this scenario?
>

I did look at modifying mptcp_incoming_options(), but this patch looked =

like the simpler fix.

The existing checks for empty packets in mptcp_incoming_options() =

accomplish two things:

1. DATA_FIN is handled for ACK packets that don't get in to the subflow =

receive queue (TCP FIN packets do go in to the receive queue, even if =

there's no payload).

2. skb_ext attachment is skipped for ACK packets.


Changing the logic in mptcp_incoming_options() would have to look for =

seq+1 =3D=3D end_seq and TCP FIN, and then (maybe?) not attach the skb_ext =
- =

which significantly changes the code paths involved. It might also do an =

extra wake up of the worker before the MPTCP socket is caught up with the =

incoming data.

In comparison, the above patch stores a return value that was previously =

(incorrectly) ignored, and schedules the worker when it is most likely to =

be able to do the work.

Given that, do you think it's better to extend the =

mptcp_incoming_options() checks?

--
Mat Martineau
Intel
--===============3625168578251952464==--
