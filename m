Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0E38A71F;
	Tue, 10 Mar 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143698; cv=none; b=b2na+ODqGeJlTnhVwyEEuVTU9LCTRYDE1NX4YNDnVqTO36wafm7rKh8pumRyPzH3rHGczw/hf7U8vgOrCNKjkddMv5rQTRloIoyHjy4tP7PL8VtphtXRAD45Vv2bopOTz9AXstQRkVtyKmLmZmG6l/5gZtyJwyDFECuUKp2O9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143698; c=relaxed/simple;
	bh=JJ0/wgz5fHNJeUNDzrX/vGzpt/sg5tDTkEJEVh7c6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D66iQgMTKpg67B/z2rkEq8TRdYRiFJrq0RyLzGtNS8Ft1didenq9e3pKBmoe+3fJbzCs3JQVyAuA81QE3el48ray4VGxp6vuU91tiAP6MkHcUwfxCsbhzzIurjr0HD0djw9Wkas8D7odd8V2eJvcM+kAnQkJOA2tZhyGENrlFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R6x7Cjvu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6x7Cjvu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6YUglPdTeT6PnJ2VigHuPaBWpc+wHGHPrtyvjVV6qA0=; b=R6x7CjvuXPCoP6BGCRfRaOSi1f
	2omxMlzdTHgcbeIAwTLRL7FtITb4pdwvJLsNfX3gOgddtPAp06k6jAZivoy4mIDMcv+wqQ/OGebD5
	DqG68XVNyc9kV3AYj4WYGAvawUEY+713TRJPU6CeF+TaTH9YupXptRq+w86Ng70i0FAqChDG9ux8s
	8RK1VBEkDIaSa8gyzmHJu3qG2wlCqSyT3Z1rnEY3XwxKtKFsmQmFXiUTw0gNv9YNh38BltrxbIRUz
	OlIdHCj+AFEXfS3JtTIZacl3w1RW16QG7RKL/3U7hj5fbKCRhwyK8qcanfzQH85+3/S42ov9HnENN
	Pgv45iqQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzvfc-00000007lSG-00ba;
	Tue, 10 Mar 2026 11:54:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1BF030027B; Tue, 10 Mar 2026 12:54:33 +0100 (CET)
Date: Tue, 10 Mar 2026 12:54:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
	rcu@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, luto@kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <MKoutny@suse.com>,
	Waiman Long <longman@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups, RCU
 stalls, timeout
Message-ID: <20260310115433.GV1282955@noisy.programming.kicks-ass.net>
References: <87v7f61cnl.ffs@tglx>
 <57c1e171-9520-4288-9e2d-10a72a499968@kernel.org>
 <87pl5ds88r.ffs@tglx>
 <0ae4d678-5676-4523-bae3-5ad73b526e27@kernel.org>
 <87eclsrtqg.ffs@tglx>
 <e846cb5f-65c4-4a9b-9f9b-593e4af526d8@kernel.org>
 <76e2b909-98db-49de-a8eb-f6f0a192f630@kernel.org>
 <878qc0rofr.ffs@tglx>
 <874imorobw.ffs@tglx>
 <4cad1b9a-e157-427b-9896-cf54cf6fba36@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cad1b9a-e157-427b-9896-cf54cf6fba36@kernel.org>

On Tue, Mar 10, 2026 at 12:24:02PM +0100, Matthieu Baerts wrote:

> Just did. Output is available there:
> 
>   https://github.com/user-attachments/files/25867817/issue-617-debug-20260310.txt.gz
> 
> Only 7.7k lines this time.

Same damn thing again...

[    2.533811] virtme-n-1         3d..1. 849756us : mmcid_user_add: pid=1 users=1 mm=000000002b3f8459
[    4.523998] virtme-n-1         3d..1. 1115085us : mmcid_user_add: pid=71 users=2 mm=000000002b3f8459
[    4.529065] virtme-n-1         3d..1. 1115937us : mmcid_user_add: pid=72 users=3 mm=000000002b3f8459

[    4.529448] virtme-n-71        2d..1. 1115969us : mmcid_user_add: pid=73 users=4 mm=000000002b3f8459         <=== missing!
[    4.529946] virtme-n-71        2d..1. 1115971us : mmcid_getcid: mm=000000002b3f8459 cid=00000003

71 spawns 73, assigns cid 3

[    4.530573]   <idle>-0         1d..2. 1115991us : sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=virtme-ng-init next_pid=73 next_prio=120
[    4.530865]   <idle>-0         1d..2. 1115993us : mmcid_cpu_update: cpu=1 cid=00000003 mm=000000002b3f8459

It gets scheduled on CPU-1, sets CID...

[    4.531038] virtme-n-1         3d..1. 1116013us : mmcid_user_add: pid=74 users=5 mm=000000002b3f8459

Then 1 spawns 74 on CPU 3, this is the 5th task, so we initiate a
task->cpu cid transition:

[    4.531203] virtme-n-1         3d..1. 1116014us : mmcid_task_update: pid=1 cid=20000000 mm=000000002b3f8459
[    4.531369] virtme-n-1         3d..1. 1116014us : mmcid_cpu_update: cpu=3 cid=20000000 mm=000000002b3f8459

Task 1

[    4.531530] virtme-n-1         3..... 1116014us : mmcid_fixup_task: pid=71 cid=00000001 active=1 users=4 mm=000000002b3f8459
[    4.531790] virtme-n-1         3d..2. 1116015us : mmcid_task_update: pid=71 cid=80000000 mm=000000002b3f8459
[    4.532000] virtme-n-1         3d..2. 1116015us : mmcid_putcid: mm=000000002b3f8459 cid=00000001

Task 71

[    4.532169] virtme-n-1         3..... 1116015us : mmcid_fixup_task: pid=72 cid=00000002 active=1 users=3 mm=000000002b3f8459
[    4.532362] virtme-n-1         3d..2. 1116016us : mmcid_task_update: pid=72 cid=20000002 mm=000000002b3f8459
[    4.532514] virtme-n-1         3d..2. 1116016us : mmcid_cpu_update: cpu=0 cid=20000002 mm=000000002b3f8459

Task 72

[    4.532649] virtme-n-1         3..... 1116016us : mmcid_fixup_task: pid=74 cid=80000000 active=1 users=2 mm=000000002b3f8459

Task 74, note the glaring lack of 73!!! which all this time is running
on CPU 1. Per the fact that it got scheduled it must be on tasklist,
per the fact that 1 spawns 74 after it on CPU3, we must observe any
prior tasklist changes and per the fact that it got a cid ->active must
be set. WTF!

That said, we set active after tasklist_lock now, so it might be
possible we simply miss that store, observe the 'old' 0 and skip over
it?

Let me stare hard at that...


[    4.532912] virtme-n-1         3..... 1116017us : mmcid_fixup_task: pid=71 cid=80000000 active=1 users=1 mm=000000002b3f8459
[    4.533386] virtme-n-1         3d..2. 1116041us : mmcid_cpu_update: cpu=3 cid=40000000 mm=000000002b3f8459

I *think* this is the for_each_process_thread() hitting 71 again.

[    4.533805]   <idle>-0         2d..2. 1116043us : mmcid_getcid: mm=000000002b3f8459 cid=00000001
[    4.533980]   <idle>-0         2d..2. 1116044us : mmcid_cpu_update: cpu=2 cid=40000001 mm=000000002b3f8459
[    4.534156]   <idle>-0         2d..2. 1116044us : mmcid_task_update: pid=74 cid=40000001 mm=000000002b3f8459
[    4.534579] virtme-n-72        0d..2. 1116046us : mmcid_cpu_update: cpu=0 cid=40000002 mm=000000002b3f8459

[    4.535803] virtme-n-73        1d..2. 1116179us : sched_switch: prev_comm=virtme-ng-init prev_pid=73 prev_prio=120 prev_state=S ==> next_comm=swapper/1 next_pid=0 next_prio=120

And then after all that, 73 blocks.. not having been marked TRANSIT or
anything and thus holding on to the CID, leading to all this trouble.



