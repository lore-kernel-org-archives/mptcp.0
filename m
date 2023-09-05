Received: from rn-mailsvcp-mx-lapp01.apple.com (rn-mailsvcp-mx-lapp01.apple.com [17.179.253.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588DDDB6
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 21:22:31 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by rn-mailsvcp-mx-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S0J002BQ7DBR320@rn-mailsvcp-mx-lapp01.rno.apple.com>
 for mptcp@lists.linux.dev; Tue, 05 Sep 2023 14:22:24 -0700 (PDT)
X-Proofpoint-ORIG-GUID: zgM-JZwIdtm_HClIBeMdrDlLQrFDSdml
X-Proofpoint-GUID: zgM-JZwIdtm_HClIBeMdrDlLQrFDSdml
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.601,18.0.957
 definitions=2023-09-05_13:2023-09-05,2023-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=641
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=cZ1LWYLgMKgWWUz1B4qqzprrusC2rKom94gBIR8IGcc=;
 b=M18mFSoDuGsc32XJKVEIcX/HSTiNvddVnd0eOdbA+4tGQdyudVuEz3UmUJhCZ3FV9xOm
 YxMThm5DPIkgXPzJltUW51x+wS2tqk33bFnuOMzB9fRdISYplKOGwnGHKpahVxgsKq87
 bG8GFA/OclRoIF7StL8YQfINGX9Gm3i6jhE9mGi/P3V7bRnZ+JX4gWCSzKRElTKBu09k
 VX5DPDao+XOEf0p+9PuxjHBTLIWIXqT9XawQ3N57LhZdOqijN0a/2mFVC7V96rq1Pt8O
 bU7U3mYEo/rB9L9SWij01qV86NiK8uXzyQHEB4V4esTiMbsIJkKVMo8V19x0OSQP5obr tg==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S0J00S6M7DA2TF0@rn-mailsvcp-mta-lapp04.rno.apple.com>;
 Tue, 05 Sep 2023 14:22:22 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S0J00B0072CTF00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Tue,
 05 Sep 2023 14:22:22 -0700 (PDT)
X-Va-A:
X-Va-T-CD: de104c1c1a6dd307621bf9e83f97afa5
X-Va-E-CD: 2b3483cc51d778a83b3be5915b056b7f
X-Va-R-CD: 0eef42286f64395431e9696be9476630
X-Va-ID: 7eb63d4d-13ba-4bec-8a9c-4f1cebb9b4ef
X-Va-CD: 0
X-V-A:
X-V-T-CD: de104c1c1a6dd307621bf9e83f97afa5
X-V-E-CD: 2b3483cc51d778a83b3be5915b056b7f
X-V-R-CD: 0eef42286f64395431e9696be9476630
X-V-ID: ba938645-e90d-4088-b04b-3b2383f25a5e
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.601,18.0.957
 definitions=2023-09-05_13:2023-09-05,2023-09-05 signatures=0
Received: from smtpclient.apple ([17.192.155.113])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S0J00JHB7DAK200@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Tue,
 05 Sep 2023 14:22:22 -0700 (PDT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.2\))
Subject: Re: kmemleak handling of kfree_rcu
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <ZPZKsJUPVeHCsLQB@arm.com>
Date: Tue, 05 Sep 2023 14:22:13 -0700
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Content-transfer-encoding: quoted-printable
Message-id: <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: Apple Mail (2.3774.100.2.1.2)

Hello Catalin,

> On Sep 4, 2023, at 2:22=E2=80=AFPM, Catalin Marinas =
<catalin.marinas@arm.com> wrote:
>=20
> Hi Christoph,
>=20
> Please try not to send html, many servers block such emails.

Sorry for that=E2=80=A6 wasn=E2=80=99t expecting my mail-client to come =
into my way...

>=20
> Also adding the RCU list.
>=20
> On Wed, Aug 30, 2023 at 09:37:23AM -0700, Christoph Paasch wrote:
>> for the MPTCP upstream project, we are running syzkaller [1] =
continuously to
>> qualify our kernel changes.
>>=20
>> We found one issue with kmemleak and its handling of kfree_rcu.
>>=20
>> Specifically, it looks like kmemleak falsely reports memory-leaks =
when the
>> object is being freed by kfree_rcu after a certain grace-period.
>>=20
>> For example, =
https://github.com/multipath-tcp/mptcp_net-next/issues/398#
>> issuecomment-1584819482 shows how the syzkaller program reliably =
produces a
>> kmemleak report, although the object is not leaked (we confirmed that =
by simply
>> increasing MSECS_MIN_AGE to something larger than the grace-period).
>=20
> Not sure which RCU variant you are using but most likely the false
> positives are caused by the original reference to the object being =
lost
> and the pointer added to a new location that kmemleak does not track
> (e.g. bnode->records[] in the tree-based variant).
>=20
> A quick attempt (untested, not even compiled):

I tried out your patch. It does resolve the false positive !

However, I am occasionally getting a report of a single object being =
leaked. When I try to visualize it with `cat =
/sys/kernel/debug/kmemleak`, the object does not show up anymore=E2=80=A6

So, something else seems to be going on here as well now.


If you have an updated patch, let me know. I can test it.


Thanks,
Christoph

>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1449cb69a0e0..681a1eb7560a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -53,6 +53,7 @@
> #include <linux/sysrq.h>
> #include <linux/kprobes.h>
> #include <linux/gfp.h>
> +#include <linux/kmemleak.h>
> #include <linux/oom.h>
> #include <linux/smpboot.h>
> #include <linux/jiffies.h>
> @@ -2934,6 +2935,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
>=20
> llist_for_each_safe(pos, n, page_list) {
> free_page((unsigned long)pos);
> + kmemleak_free(pos);
> freed++;
> }
>=20
> @@ -2962,8 +2964,16 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
> rcu_state.name, bnode->records[i], 0);
>=20
> vfree(bnode->records[i]);
> + /* avoid false negatives */
> + kmemleak_erase(&bnode->records[i]);
> }
> }
> + /*
> + * Avoid kmemleak false negatives when such pointers are later
> + * re-allocated.
> + */
> + for (i =3D 0; i < bnode->nr_records; i++)
> + kmemleak_erase(&bnode->records[i]);
> rcu_lock_release(&rcu_callback_map);
> }
>=20
> @@ -2972,8 +2982,10 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
> bnode =3D NULL;
> raw_spin_unlock_irqrestore(&krcp->lock, flags);
>=20
> - if (bnode)
> + if (bnode) {
> free_page((unsigned long) bnode);
> + kmemleak_free(bnode);
> + }
>=20
> cond_resched_tasks_rcu_qs();
> }
> @@ -3241,6 +3253,12 @@ static void fill_page_cache_func(struct =
work_struct *work)
> free_page((unsigned long) bnode);
> break;
> }
> +
> + /*
> + * Scan the bnode->records[] array until the objects are
> + * actually freed.
> + */
> + kmemleak_alloc(bnode, PAGE_SIZE, 0, GFP_KERNEL);
> }
>=20
> atomic_set(&krcp->work_in_progress, 0);
> @@ -3308,6 +3326,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu =
**krcp,
> // scenarios.
> bnode =3D (struct kvfree_rcu_bulk_data *)
> __get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | =
__GFP_NOWARN);
> + /*
> + * Scan the bnode->records[] array until the objects are
> + * actually freed.
> + */
> + kmemleak_alloc(bnode, PAGE_SIZE, 0, GFP_KERNEL);
> raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
> }
>=20
>=20
> --=20
> Catalin
>=20

