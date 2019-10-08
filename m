Content-Type: multipart/mixed; boundary="===============6642749393098084977=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Tue, 08 Oct 2019 11:08:41 +0200
Message-ID: <5b077f34-3255-0b9e-4d6f-7793ffb8e483@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910071541250.18088@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2042

--===============6642749393098084977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 08/10/2019 00:54, Mat Martineau wrote:
> =

> Matthieu,
> =

> On Mon, 7 Oct 2019, Matthieu Baerts wrote:
> =

>> On 07/10/2019 17:23, Florian Westphal wrote:
>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>> On 07/10/2019 17:00, Florian Westphal wrote:
>>>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>>>>> ... this turns 'tcp: clean ext on tx recycle' into a one-line =

>>>>>>> change.
>>>>>>
>>>>>> Good idea! Just applied this diff and added your signed-off to the =

>>>>>> patch.
>>>>>
>>>>> Thanks!
>>>>
>>>> Just in case you want to check, here is the diff between my two =

>>>> branches:
>>>
>>> [..]
>>>
>>>> If there is no objection, I am going to re-create the TopGit tree =

>>>> with this
>>>> new branch then!
>>>
>>> Looks good, go ahead.
>>
>> TopGit tree re-created, export branch has been recreated, tests are =

>> still OK.
>>
> =

> =

> I have one more change to suggest. In "tcp: Expose tcp struct and =

> routine for MPTCP", we don't need to expose tcp_v4_init_sock() - that =

> was probably associated with the pre-ULP code.

Good catch!

> That reduces the patch to only exporting tcp_request_sock_ipv4_ops, =

> which I would suggest squashing with "tcp: Export low-level TCP =

> functions"

That's a good idea!

While I am on it, I think it would be better to move this to the end of =

the first part of the series as it is just exposing things needed for =

later, no bug fix if the code is extended in a specific way or =

introduction to MPTCP. But maybe that's a detail?


Also, regarding tcp_request_sock_ipv4_ops, should we already expose the =

IPv6 version?


=3D=3D=3D=3D
diff --git a/include/net/tcp.h b/include/net/tcp.h
index daa35c2b9584..138aec1e2ed8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1986,6 +1986,11 @@ struct tcp_request_sock_ops {
                            enum tcp_synack_type synack_type);
  };

+extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
+#if IS_ENABLED(CONFIG_IPV6)
+extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
+#endif
+
  #ifdef CONFIG_SYN_COOKIES
  static inline __u32 cookie_init_sequence(const struct =

tcp_request_sock_ops *ops,
                                          const struct sock *sk, struct =

sk_buff *skb,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5cb0e7f065ea..ea926e4c13f1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1369,7 +1369,7 @@ struct request_sock_ops tcp_request_sock_ops =

__read_mostly =3D {
         .syn_ack_timeout =3D      tcp_syn_ack_timeout,
  };

-static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
         .mss_clamp      =3D       TCP_MSS_DEFAULT,
  #ifdef CONFIG_TCP_MD5SIG
         .req_md5_lookup =3D       tcp_v4_md5_lookup,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e3d9f4559c99..fbf34f575a29 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -784,7 +784,7 @@ struct request_sock_ops tcp6_request_sock_ops =

__read_mostly =3D {
         .syn_ack_timeout =3D      tcp_syn_ack_timeout,
  };

-static const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
+const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
         .mss_clamp      =3D       IPV6_MIN_MTU - sizeof(struct tcphdr) -
                                 sizeof(struct ipv6hdr),
  #ifdef CONFIG_TCP_MD5SIG
=3D=3D=3D=3D


WDYT?

> and then updating the commit message:
> =

> """
> tcp: Export TCP functions and ops struct
> =

> MPTCP will make use of tcp_send_mss() and tcp_push() when sending
> data to specific TCP subflows.
> =

> tcp_request_sock_ipv4_ops will be referenced during TCP subflow creation.
> =

> """

Thank you for the message, I will update it too!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6642749393098084977==--
