Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62123CA60
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 11:17:26 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-792623074edso64995239f.1
        for <mptcp@lists.linux.dev>; Tue, 05 Sep 2023 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693912646; x=1694517446; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFr3guuenGyb3Qn0aVjZt6j2hEqhzlyTzGXreRyxiz4=;
        b=kXyfMVuBUXV0EtsBiiBxPOJj44acyiuVUIxPGs9iHjq4CfysA257mNl3eDvQS3Qx8r
         7mK3jfJcsV0338Ja1x9h10Jfx52RjtDQHzHJpRGvWD2b2TFUCJbZA5mx2Kavqil/04kp
         UxLnb4E6k97YNaw/elfHgzA6nuGKvjmGFu2rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693912646; x=1694517446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFr3guuenGyb3Qn0aVjZt6j2hEqhzlyTzGXreRyxiz4=;
        b=EZMBA1QFMt+Nc7HVs2iM6fQYIzbS0tqHOdtC39bNpbrkE2MBEZBkr3uaoD6S+3K/Gd
         rfTr7LBeTCYAaSOWXAuhVStk0pHGNmVGosoR+/F4VUlSCsG2xO1vfIlnlTQdLbAW4mqW
         NX5KfeazhwUXNYdsr0VW3y8YxeiJH6mWVNB+F8F8UxoywDWKJVvpkl3yNy6n0W6Rc9LV
         H8zoSiJQ+Woa31sVus8T+pOSvvRmrb7QVvueuhpuXG6EoWnn/9yvFilDMr1tjSjCjCJf
         dna4LQtulnYDQrPza7IEKCtmrieEqbG8OC3qsZcBzRnHJde0IwR78pqGy4FvQCMb8ryM
         +kjg==
X-Gm-Message-State: AOJu0YxHVP16jVbq2chRbwIwOWM9sFSsZiGiA5W0htImWCBhzspBra9f
	qVVSwGIN/S9jjWOpN7AFUcCKtA==
X-Google-Smtp-Source: AGHT+IH6ATLWvEQISqMYhYAvtisc3efnqHLoJKTqFihvNieOXuIdabwt3JbtmE5N7gFtoTpoNI0Ylw==
X-Received: by 2002:a05:6602:19c5:b0:794:eb37:b0da with SMTP id ba5-20020a05660219c500b00794eb37b0damr10714307iob.2.1693912645977;
        Tue, 05 Sep 2023 04:17:25 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id n7-20020a6b7207000000b0077e3acd5ea1sm4221764ioc.53.2023.09.05.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:17:25 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:17:25 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Paasch <cpaasch@apple.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <20230905111725.GA3737639@google.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPZKsJUPVeHCsLQB@arm.com>

On Mon, Sep 04, 2023 at 10:22:56PM +0100, Catalin Marinas wrote:
> Hi Christoph,
> 
> Please try not to send html, many servers block such emails.
> 
> Also adding the RCU list.
> 
> On Wed, Aug 30, 2023 at 09:37:23AM -0700, Christoph Paasch wrote:
> > for the MPTCP upstream project, we are running syzkaller [1] continuously to
> > qualify our kernel changes.
> > 
> > We found one issue with kmemleak and its handling of kfree_rcu.
> > 
> > Specifically, it looks like kmemleak falsely reports memory-leaks when the
> > object is being freed by kfree_rcu after a certain grace-period.
> > 
> > For example, https://github.com/multipath-tcp/mptcp_net-next/issues/398#
> > issuecomment-1584819482 shows how the syzkaller program reliably produces a
> > kmemleak report, although the object is not leaked (we confirmed that by simply
> > increasing MSECS_MIN_AGE to something larger than the grace-period).
> 
> Not sure which RCU variant you are using but most likely the false
> positives are caused by the original reference to the object being lost
> and the pointer added to a new location that kmemleak does not track
> (e.g. bnode->records[] in the tree-based variant).
> 
> A quick attempt (untested, not even compiled):
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c

I am not sure if that works. Correct me if I'm wrong but the issue is that
the allocated pointer being RCU-freed is no longer reachable by kmemleak (it
is scanned but not reachable), however it might still be reachable via an
RCU reader. In such a situation, it is a false-positive.

The correct fix then should probably be to mark the object as
kmemleak_not_leak() until a grace period elapses. This will cause the object
to not be reported but still be scanned until eventually the lower layers
will remove the object from kmemleak-tracking after the grace period. Per the
docs also, that API is used to prevent false-positives.

Instead what the below diff appears to do is to mark the bnode cache as a
kmemleak object itself, which smells a bit wrong. The bnode is not an
allocated object in the traditional sense, it is simple an internal data
structure. That may not solve the issue as the false-positive unreachable
object is still unreachable.

Or did I misunderstand how kmemleak works? (Quite possible).

thanks,

 - Joel


> index 1449cb69a0e0..681a1eb7560a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -53,6 +53,7 @@
>  #include <linux/sysrq.h>
>  #include <linux/kprobes.h>
>  #include <linux/gfp.h>
> +#include <linux/kmemleak.h>
>  #include <linux/oom.h>
>  #include <linux/smpboot.h>
>  #include <linux/jiffies.h>
> @@ -2934,6 +2935,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
>  
>  	llist_for_each_safe(pos, n, page_list) {
>  		free_page((unsigned long)pos);
> +		kmemleak_free(pos);
>  		freed++;
>  	}
>  
> @@ -2962,8 +2964,16 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
>  					rcu_state.name, bnode->records[i], 0);
>  
>  				vfree(bnode->records[i]);
> +				/* avoid false negatives */
> +				kmemleak_erase(&bnode->records[i]);
>  			}
>  		}
> +		/*
> +		 * Avoid kmemleak false negatives when such pointers are later
> +		 * re-allocated.
> +		 */
> +		for (i = 0; i < bnode->nr_records; i++)
> +			kmemleak_erase(&bnode->records[i]);
>  		rcu_lock_release(&rcu_callback_map);
>  	}
>  
> @@ -2972,8 +2982,10 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
>  		bnode = NULL;
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
> -	if (bnode)
> +	if (bnode) {
>  		free_page((unsigned long) bnode);
> +		kmemleak_free(bnode);
> +	}
>  
>  	cond_resched_tasks_rcu_qs();
>  }
> @@ -3241,6 +3253,12 @@ static void fill_page_cache_func(struct work_struct *work)
>  			free_page((unsigned long) bnode);
>  			break;
>  		}
> +
> +		/*
> +		 * Scan the bnode->records[] array until the objects are
> +		 * actually freed.
> +		 */
> +		kmemleak_alloc(bnode, PAGE_SIZE, 0, GFP_KERNEL);
>  	}
>  
>  	atomic_set(&krcp->work_in_progress, 0);
> @@ -3308,6 +3326,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  			// scenarios.
>  			bnode = (struct kvfree_rcu_bulk_data *)
>  				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> +			/*
> +			 * Scan the bnode->records[] array until the objects are
> +			 * actually freed.
> +			 */
> +			kmemleak_alloc(bnode, PAGE_SIZE, 0, GFP_KERNEL);
>  			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
>  		}
>  
> 
> -- 
> Catalin
