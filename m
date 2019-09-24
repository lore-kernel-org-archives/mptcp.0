Content-Type: multipart/mixed; boundary="===============1664854798224873227=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] net/mptcp: rcu-ify the subflow context
Date: Tue, 24 Sep 2019 18:23:45 +0200
Message-ID: <de6b05cf-a976-0d2f-dbf6-948a02504bbe@tessares.net>
In-Reply-To: d8f6a1ff7934e99311c8d7851e691d803da272a8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1918

--===============1664854798224873227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Paolo,

On 24/09/2019 17:42, Davide Caratti wrote:
> On Tue, 2019-09-24 at 14:18 +0200, Matthieu Baerts wrote:
>> Hi Davide, Paolo,
>>
>> On 20/09/2019 17:22, Paolo Abeni wrote:
>>> On Thu, 2019-09-19 at 18:08 +0200, Davide Caratti wrote:
>>>> On Fri, 2019-09-13 at 17:54 +0200, Paolo Abeni wrote:
>>>>> The patch looks fine, but I'm still wondering if we should try to be
>>>>> more conservative here, using something alike:
>>>>>
>>>>> 	return rcu_dereference_protected(icsk->icsk_ulp_data,
>>>>> 		lockdep_sock_is_held((struct sock *)icsk))
>>>>>
>>>>> and fixing the eventual lockdep splat explcitily
>>>>>
>>>>> (possibly we may need a different/additional condition for
>>>>> rcu_dereference_protected() based  on icsk refcnt)
>>>>
>>>> this is for sure, because the socket lock for icsk is often not held w=
hen
>>>> subflow_ctx() is called. Nevertheless, icsk_ulp_data is a valid pointe=
r in
>>>> all the traffic path of MPTCP (and it keeps the same value until it's
>>>> freed at the enf of the grace period). Should we do a function that do=
es
>>>> the atomic read of sk_refcnt when lockdep is on? =

>>>
>>> I re-read the relevant code, and I changed a bit my mind: the usage of
>>> rcu_dereference_protected() without a condition not based on a lock is
>>> a bit ackward. =

>>>
>>> Other similar use-case do force the correct annotation, as in this
>>> patch.
>>>
>>> So I'm fine with the posted code.
>>>
>>> I'm sorry for useless delay/blocking.
>>
>> Sorry this time the delay was on my side. Because of the "RFC" tag, I
>> didn't put the patch on my list. But can you just confirm that I can
>> apply this patch, nothing else is coming?
> =

> Hello Matthieu,
> =

> I have no plans to improve the current code w.r.t. this patch. Unless
> anybody disagrees, I'm for applying it as-is (and squashing it into
> "mptcp: Implement MPTCP receive path" ).

Great!

Thank you for the patch and the review!

- ae79303bf919: "squashed" in "mptcp: Implement MPTCP receive path"
- 5c3ebb640609: "signed-off"
- 4c186ad4f312..549f7224b7cd: result

Note: because of other changes made by Florian and Paolo, my diff in
subflow_ulp_release() is slightly different than yours:

=3D=3D=3D=3D
@@ -445,10 +444,13 @@ static void subflow_ulp_release(struct sock *sk)
 {
        struct subflow_context *ctx =3D subflow_ctx(sk);

+       if (!ctx)
+               return;
+
        if (ctx->conn)
                sock_put(ctx->conn);

-       kfree(ctx);
+       kfree_rcu(ctx, rcu);
 }

 static void subflow_ulp_clone(const struct request_sock *req,
=3D=3D=3D=3D

token_release() has been removed, sock_put() has been added. Just to be
sure, does it still make sense to check if ctx is not NULL?

You can see 5ee88b657e3f (mptcp: remove token_release) for example for
more details about the other modifications that were made recently.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1664854798224873227==--
