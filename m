Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF717E8
	for <mptcp@lists.linux.dev>; Sat, 25 Feb 2023 01:53:22 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.21.20230112 64bit (built Jan 12
 2023)) with ESMTPS id <0RQM006CL2GSJU10@ma-mailsvcp-mx-lapp01.apple.com> for
 mptcp@lists.linux.dev; Fri, 24 Feb 2023 16:53:16 -0800 (PST)
X-Proofpoint-ORIG-GUID: m77xwjOHIXXomGhOmaEVdTGQFFc6QVXw
X-Proofpoint-GUID: m77xwjOHIXXomGhOmaEVdTGQFFc6QVXw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.562,18.0.930
 definitions=2023-02-24_18:2023-02-23,2023-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 phishscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302250002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=2HcumZPRRQ+X8q205cutWwx8Uxy7XGWN0G/ExalzJXw=;
 b=mhhc8E7lnRxRFae8uBS7Ktc4z9y3GuSuc5eUy3hxWWHzmJIVV8cvCPqRC+4c7rJlEike
 /Sibcd9yY0mbwxqNUa3Atz7reAq4nBYfeob+P3mx1BnuJ+pSWdL3SJ46PFamacTAk+I1
 no04WRqJiEQke1v/eE0sQwQbjNHa4KI3o6TNTagafGbiFfU+ZB0GYpQzP4J9s64W5Meg
 x55DzRHDKfT8fAyvll+gbVeZnZgSPltpW2Qrz1+UqVyHabZCKCR/xQyGn01pihxKK9KT
 qoeCCzZ9D0X3LlySby6K/+AYLJLiGDpPSvs0lA3So8AzMyvhmgnhS9jz8ddNdCYUHFnN jw==
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.21.20230112 64bit (built Jan 12
 2023)) with ESMTPS id <0RQM00QHB2GJZ700@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Fri, 24 Feb 2023 16:53:15 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) id <0RQM00W002AQMY00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Fri,
 24 Feb 2023 16:53:13 -0800 (PST)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 00c874777b0628ef496a6e93c9677a02
X-Va-R-CD: 770ac1f3500ac7de59cbb2734caf72d5
X-Va-ID: c0c741e9-7caa-466a-a0c1-4a2b7cc158e9
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 00c874777b0628ef496a6e93c9677a02
X-V-R-CD: 770ac1f3500ac7de59cbb2734caf72d5
X-V-ID: 955ed330-3785-4764-858f-46a44205877f
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.562,18.0.930
 definitions=2023-02-24_18:2023-02-23,2023-02-24 signatures=0
Received: from smtpclient.apple (unknown [17.11.93.53])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022))
 with ESMTPSA id <0RQM010402GNJD00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Fri,
 24 Feb 2023 16:53:12 -0800 (PST)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.500.161\))
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket()
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Date: Fri, 24 Feb 2023 16:53:01 -0800
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <D0E3A8A0-E777-4C7B-941E-092AF39E02E4@apple.com>
References:
 <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.500.161)



> On Feb 24, 2023, at 4:01 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
> error path, when such function is invoked by
> mptcp_pm_nl_create_listen_socket().
>=20
> Such code path acquires two separates, nested socket lock, with the
> internal lock operation lacking the "nested" annotation. Adding that
> in sock_release() for mptcp's sake only could be confusing.
>=20
> Instead just add a new lockclass to the in-kernel msk socket,
> re-initializing the lockdep infra after the socket creation.
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener =
creation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)

Works!

Tested-by: Christoph Paasch <cpaasch@apple.com>



>=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d1d859517d91..6048fdee404b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -994,9 +994,13 @@ static int =
mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
> 	return ret;
> }
>=20
> +static struct lock_class_key mptcp_slock_keys[2];
> +static struct lock_class_key mptcp_keys[2];
> +
> static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 					    struct mptcp_pm_addr_entry =
*entry)
> {
> +	bool is_ipv6 =3D sk->sk_family =3D=3D AF_INET6;
> 	int addrlen =3D sizeof(struct sockaddr_in);
> 	struct sockaddr_storage addr;
> 	struct socket *ssock;
> @@ -1013,6 +1017,19 @@ static int =
mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 	if (!newsk)
> 		return -EINVAL;
>=20
> +	/* The subflow socket lock is acquired in a nested to the msk =
one
> +	 * in several places, even by the TCP stack, and this msk is a =
kernel
> +	 * socket: lockdep complains. Instead of propagating the _nested
> +	 * modifiers in several places, re-init the lock class for the =
msk
> +	 * socket to an mptcp specific one.
> +	 */
> +	sock_lock_init_class_and_name(
> +			newsk,
> +			is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> +			&mptcp_slock_keys[is_ipv6],
> +			is_ipv6 ? "msk_lock-AF_INET6": =
"msk_lock-AF_INET",
> +			&mptcp_keys[is_ipv6]);
> +
> 	lock_sock(newsk);
> 	ssock =3D __mptcp_nmpc_socket(mptcp_sk(newsk));
> 	release_sock(newsk);
> --=20
> 2.39.2
>=20
>=20

